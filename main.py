# This Python file uses the following encoding: utf-8
import sys
from pathlib import Path
import random
import rsp
import DB

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QObject, Slot, Signal


class MainWindow(QObject):
    def __init__(self):
        QObject.__init__(self)

    # SignalSetName
    getName = Signal(str)

    # SignalBattleResults
    getResult = Signal(str)
    getCounter = Signal(int)
    getMsg = Signal(str)

    # SignalPlayerChoice
    getPlayerChoice = Signal(int)

    # SignalComputerAction
    computerAction = Signal(int)

    getTopScore = Signal(str)



    # Function to get player choice
    @Slot(int)
    def sendPlayerChoice(self, choice):
        self.choice = choice
        self.getPlayerChoice.emit(choice)

    # Function Set name to Label
    @Slot(str)
    def welcomeText(self, name):
        self.name = name
        connection = DB.create_connection('./DB_rsp.sqlite')
        DB.execute_query(connection, DB.create_users_table)
        DB.execute_query(connection, DB.create_score_table)
        DB.execute_query(connection, DB.create_record_table)
        select_users = "SELECT name FROM users"
        users = DB.execute_read_query(connection, select_users)
        if not users:
            create_user = f"INSERT INTO users VALUES (NULL, '{name}')"
            DB.execute_query(connection, create_user)
        else:
            for user in users:
                if name in user:
                    break
                else:
                    create_user = f"INSERT INTO users VALUES (NULL, '{name}')"
                    DB.execute_query(connection, create_user)
                    break
        select_user_id = f"SELECT id FROM users WHERE name = '{name}'"
        user_id = DB.execute_read_query(connection, select_user_id)
        self.user_id = user_id
        self.getName.emit('Welcome, ' + name)

    @Slot(bool)
    def sendComputerAction(self, toggle):
        if toggle:
            action = random.randint(1, 3)
            self.action = action
            self.computerAction.emit(action)

    @Slot()
    def sendBattleResult(self):
        result, counter = rsp.battle(self.action, self.choice)
        self.getResult.emit(result)
        self.getCounter.emit(counter)
        if abs(counter) % 10 == 1:
            msg = f'Поздравляю, Вы набрали {counter} очко.'
        elif abs(counter) % 10 > 1 and abs(counter) % 10 < 5:
            msg = f'Поздравляю, Вы набрали {counter} очка.'
        else:
            msg = f'Поздравляю, Вы набрали {counter} очков.'
        self.getMsg.emit(msg)

    @Slot(str)
    def counterToDB(self, countertodb):
        countertodb = int(countertodb)
        connection = DB.create_connection('./DB_rsp.sqlite')
        earned_points = f"INSERT INTO score VALUES (NULL, '{countertodb}', '{self.user_id[0][0]}')"
        DB.execute_query(connection, earned_points)

    @Slot(str)
    def sendRecordTable(self, toggle):
        connection = DB.create_connection('./DB_rsp.sqlite')
        select_record_rows = "SELECT users.name, score.points FROM users JOIN score " \
                             "ON users.id = score.user_id ORDER BY score.points DESC LIMIT 0,10"
        record_rows = DB.execute_read_query(connection, select_record_rows)
        attach = ''
        i = 0
        msgrecord = ''
        if len(record_rows) < 10:
            for k in range(len(record_rows) + 1, 11):
                attach += f'{k})|'
        for row in record_rows:
            i += 1
            msgrecord += f'{i}) {row[0]} {row[1]}|'
        msgrecord += attach
        self.getTopScore.emit(msgrecord)


if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    # Get context
    main = MainWindow()
    engine.rootContext().setContextProperty("backend", main)

    # Load Qml file

    qml_file = Path(__file__).resolve().parent / "content/App.qml"
    engine.load(qml_file)
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
