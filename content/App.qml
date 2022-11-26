/****************************************************************************
**
** Copyright (C) 2021 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of Qt Quick Studio Components.
**
** $QT_BEGIN_LICENSE:GPL$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3 or (at your option) any later version
** approved by the KDE Free Qt Foundation. The licenses are as published by
** the Free Software Foundation and appearing in the file LICENSE.GPL3
** included in the packaging of this file. Please review the following
** information to ensure the GNU General Public License requirements will
** be met: https://www.gnu.org/licenses/gpl-3.0.html.
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 6.2
import QtQuick.Window 6.2
import QtQuick.Controls 2.15


Window {
    id: mainWindow
    width: 1280
    height: 720

    visible: true
    color: "#00000000"
    maximumHeight: 1080
    maximumWidth: 1920
    minimumHeight: 720
    minimumWidth: 1280
    title: "RspQT"
    //CUSTOM PROPERTIES
    property int windowStatus: 0
    property int windowMarginUp: 9
    property int windowMarginSide: 16
    property color colorDefault: "#282c34"
    property color colorOnFocus: "#242831"
    property color colorMouseOver: "#282F38"
    //INTERNAL FUNCTIONS
    QtObject{
        id: internal

        property var dynamicColor: if(textField.focus){
                                       textField.hovered ? colorOnFocus : colorDefault
                                   }else{
                                       textField.hovered ? colorMouseOver: colorDefault
                                   }

        function maximizeRestore(){
            if(windowStatus == 0){
                mainWindow.showMaximized()
                windowStatus = 1
                windowMarginSide = 0
                windowMarginUp = 0
                btnMaximizeRestore.btnIconSource = "images/restore_icon.svg"
            }
            else{
                windowStatus = 0
                mainWindow.showNormal()
                windowMarginSide = 16
                windowMarginUp = 9
                btnMaximizeRestore.btnIconSource = "images/maximize_icon.svg"
            }
        }
    }

    //REMOVE TITTLE BAR
    flags: Qt.Window | Qt.FramelessWindowHint

    Image {
        id: background
        opacity: 1
        anchors.fill: parent
        source: "images/background1.jpg"
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        fillMode: Image.PreserveAspectFit

        Rectangle {
            id: topBar
            x: 16
            y: 9
            height: 60
            opacity: 1
            color: "#06161c"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            scale: 1
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0

            Rectangle {
                id: topBarDescription
                x: 97
                y: 111
                height: 25
                opacity: 0.7
                color: "#f105222e"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                scale: 1
                anchors.rightMargin: 0
                anchors.leftMargin: 70
                anchors.bottomMargin: 0

                Label {
                    id: labelTopInfo
                    color: "#6e6e6e"
                    text: qsTr("Created by Danil Lotfrakhmanov")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    verticalAlignment: Text.AlignVCenter
                    anchors.rightMargin: 300
                    anchors.leftMargin: 20
                    anchors.bottomMargin: 0
                    anchors.topMargin: 0
                }

                Label {
                    id: labelRightInfo
                    color: "#6e6e6e"
                    text: qsTr("|HOME")
                    anchors.left: labelTopInfo.right
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                    anchors.topMargin: 0
                    anchors.rightMargin: 10
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 0
                }
            }

            Rectangle {
                id: titleBar
                height: 35
                color: "#06161c"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.leftMargin: 70
                anchors.rightMargin: 0
                anchors.topMargin: 0

                DragHandler{
                    onActiveChanged: if(active){
                                         mainWindow.startSystemMove()
                                     }
                }
                Image {
                    id: iconApp
                    width: 22
                    height: 22
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    source: "images/icon_app_top.svg"
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 5
                    anchors.topMargin: 0
                    fillMode: Image.PreserveAspectFit
                }

                Label {
                    id: labelName
                    width: 765
                    color: "#ffffff"
                    text: qsTr("RockScissorsPaper")
                    anchors.left: iconApp.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    anchors.bottomMargin: 0
                    anchors.topMargin: 0
                    anchors.leftMargin: 5
                }

                Row {
                    id: rowBtns
                    x: 1073
                    y: 0
                    width: 105
                    height: 35
                    opacity: 1
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    anchors.rightMargin: 0

                    TopBarButton {
                        id: btnMinimize
                        opacity: 1
                        onClicked: mainWindow.showMinimized()
                    }

                    TopBarButton {
                        id: btnMaximizeRestore
                        btnIconSource: "images/maximize_icon.svg"
                        onClicked: internal.maximizeRestore()
                    }

                    TopBarButton {
                        id: btnClose
                        btnColorClicked: "#c10303"
                        btnIconSource: "images/close_icon.svg"
                        onClicked: mainWindow.close()
                    }
                }
            }

            ToggleButton { id: toggleButton ;x: 0 ;y: 0}

        }

        StartButton {
            id: startBtn
            height: 80
            visible: true
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 0
            anchors.horizontalCenterOffset: 0
            flat: false
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {animationStartOp.running = true
                animationStartMv.running = true
                animationTextFieldOp.running = true
                animationTextFieldDown.running = true
            }

            PropertyAnimation {
                id: animationStartOp
                target: startBtn
                property: "opacity"
                to: 0
                duration: 500
                easing.type: Easing.InQuad

            }

            PropertyAnimation {
                id: animationStartMv
                target: startBtn
                property: "anchors.verticalCenterOffset"
                to: 516
                duration: 3500
                easing.type: Easing.InQuad

            }
        }

        Row {
            id: rowBtnImages
            y: 464
            width: 1280
            height: 128
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 80
            anchors.horizontalCenter: parent.horizontalCenter
            rightPadding: 100
            leftPadding: 100
            spacing: 350

            AnimatedImage {
                id: animatedBtnq
                visible: false
                source: "images/q.gif"
            }


            AnimatedImage {
                id: animatedBtnw
                source: "images/w.gif"
                visible: false
            }

            AnimatedImage {
                id: animatedBtne
                visible: false
                source: "images/e.gif"
            }
        }

        Image {
            id: humanScissors
            x: -400
            width: 400
            height: 400
            visible: true
            anchors.verticalCenter: parent.verticalCenter
            anchors.top: parent.top
            source: "images/HumanScissors.png"
            anchors.topMargin: 105
            anchors.leftMargin: 0
            rotation: 0
            fillMode: Image.PreserveAspectFit

            PropertyAnimation{
                id: animationMoveRightScissors
                target: humanScissors
                property: "x"
                to: 0
                duration: 500
                easing.type: Easing.InQuad
            }
        }

        Image {
            id: robotRock
            x: 788
            width: 400
            height: 400
            visible: true
            anchors.verticalCenter: parent.verticalCenter

            anchors.right: parent.right
            anchors.top: parent.top
            source: "images/RobotRock.png"
            anchors.topMargin: 105
            anchors.rightMargin: -400
            rotation: 0
            fillMode: Image.PreserveAspectFit

            PropertyAnimation {
                id: animationMoveLeftRock
                target: robotRock
                property: "anchors.rightMargin"
                duration: 500
                easing.type: Easing.InQuad
                to: 0
            }
        }
        Image {
            id: robotScissors
            x: 788
            width: 400
            height: 400
            visible: true
            anchors.verticalCenter: parent.verticalCenter

            anchors.right: parent.right
            anchors.top: parent.top
            source: "images/RobotScissors.png"
            anchors.topMargin: 105
            anchors.rightMargin: -400
            rotation: 0
            fillMode: Image.PreserveAspectFit

            PropertyAnimation {
                id: animationMoveLeftScissors
                target: robotScissors
                property: "anchors.rightMargin"
                duration: 500
                easing.type: Easing.InQuad
                to: 0
            }
        }
        Image {
            id: robotPaper
            x: 1287
            width: 400
            height: 400
            visible: true
            anchors.verticalCenter: parent.verticalCenter

            anchors.right: parent.right
            anchors.top: parent.top
            source: "images/RobotPaper.png"
            anchors.topMargin: 105
            anchors.rightMargin: -400
            rotation: 0
            fillMode: Image.PreserveAspectFit

            PropertyAnimation {
                id: animationMoveLeftPaper
                target: robotPaper
                property: "anchors.rightMargin"
                duration: 500
                easing.type: Easing.InQuad
                to: 0
            }
        }

        Row {
            id: rowBtn
            y: 655
            width: 1280
            height: 80
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            rightPadding: 68
            leftPadding: 68
            spacing: 286
            anchors.bottomMargin: 0

            GameButtons {
                id: rockBtn
                width: 192
                height: 50
                topPadding: 10
                visible: false                
                onClicked: {
                    robotScissors.anchors.rightMargin = -400
                    robotRock.anchors.rightMargin = -400
                    robotPaper.anchors.rightMargin = -400
                    backend.sendComputerAction(true)
                    backend.sendPlayerChoice(1)
                    humanRock.x = -400
                    humanPaper.x = -400
                    humanScissors.x = -400
                    animationMoveRightRock.running = true
                    backend.sendBattleResult()
                    animatedBtne.visible = false
                    animatedBtnw.visible = false
                    animatedBtnq.visible = false
                }
            }

            GameButtons {
                id: scissorsBtn
                width: 192
                height: 50
                text: "Ножницы ✂️"
                bottomPadding: 10
                onClicked: {
                    robotScissors.anchors.rightMargin = -400
                    robotRock.anchors.rightMargin = -400
                    robotPaper.anchors.rightMargin = -400
                    backend.sendComputerAction(true)
                    backend.sendPlayerChoice(2)
                    humanRock.x = -400
                    humanPaper.x = -400
                    humanScissors.x = -400
                    animationMoveRightScissors.running = true
                    backend.sendBattleResult()
                    animatedBtne.visible = false
                    animatedBtnw.visible = false
                    animatedBtnq.visible = false
                }
                visible: false
            }

            GameButtons {
                id: paperBtn
                width: 192
                height: 50
                text: "Бумага 📄"
                bottomPadding: 10
                visible: false
                onClicked: {
                    robotScissors.anchors.rightMargin = -400
                    robotRock.anchors.rightMargin = -400
                    robotPaper.anchors.rightMargin = -400
                    backend.sendComputerAction(true)
                    backend.sendPlayerChoice(3)
                    humanRock.x = -400
                    humanPaper.x = -400
                    humanScissors.x = -400
                    animationMoveRightPaper.running = true
                    backend.sendBattleResult()
                    animatedBtne.visible = false
                    animatedBtnw.visible = false
                    animatedBtnq.visible = false
                }
            }
        }

        Image {
            id: humanRock
            x: -400
            width: 400
            height: 400
            visible: true
            anchors.verticalCenter: parent.verticalCenter
            anchors.top: parent.top
            source: "images/HumanRock.png"
            anchors.topMargin: 95
            rotation: 0
            fillMode: Image.PreserveAspectFit
            anchors.leftMargin: 0

            PropertyAnimation {
                id: animationMoveRightRock
                target: humanRock
                property: "x"
                duration: 500
                easing.type: Easing.InQuad
                to: 0
            }
        }

        Image {
            id: humanPaper
            x: -400
            width: 400
            height: 400
            visible: true
            anchors.verticalCenter: parent.verticalCenter
            anchors.top: parent.top
            source: "images/HumanPaper.png"
            anchors.topMargin: 95
            rotation: 0
            fillMode: Image.PreserveAspectFit
            anchors.leftMargin: 0

            PropertyAnimation {
                id: animationMoveRightPaper
                target: humanPaper
                property: "x"
                duration: 500
                easing.type: Easing.InQuad
                to: 0
            }
        }

        TextField {
            id: textField
            width: 250
            height: 42
            opacity: 0
            anchors.horizontalCenter: parent.horizontalCenter
            placeholderTextColor: "#6e6e6e"
            placeholderText: qsTr("Введите имя")
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -600
            background: Rectangle{
                radius: 15;
                color: internal.dynamicColor
            }
            selectByMouse: true
            selectedTextColor: "#ffffff"
            selectionColor: "#ff007f"
            PropertyAnimation{
                id: animationTextFieldDown
                target: textField
                property: "anchors.verticalCenterOffset"
                to: 0
                duration: 750
            }
            PropertyAnimation{
                id: animationTextFieldOp
                target: textField
                property: "opacity"
                to: 1
                duration: 1000
            }

            EnterButton {
                id: enterBtn
                y: 0
                width: 50
                height: 42
                text: "\u2ba8"
                anchors.right: parent.right
                icon.color: "#ffffff"
                btnColorDefault: "#4d66f4"
                btnColorMouseOver: "#e40c4862"
                btnColorClicked: "#0c5a80"
                anchors.rightMargin: -52
                onClicked:  {
                    backend.welcomeText(textField.text)
                    textField.visible = false
                    labelTextName.visible = true
                    animationlabelTextName.running = true
                    animatedBtne.visible = true
                    animatedBtnw.visible = true
                    animatedBtnq.visible = true
                    rockBtn.visible = true
                    scissorsBtn.visible = true
                    paperBtn.visible = true
                }
            }
        }


        Connections{
            target: backend

            function onGetName(name){
                labelTextName.text = name
            }

            function onComputerAction(action){
                if(action == 1){animationMoveLeftRock.running = true
                }else if (action == 2) {animationMoveLeftScissors.running = true
                }else{animationMoveLeftPaper.running = true}
            }

            function onGetResult(result){
                frameRes.visible = true
                labelResult.visible = true
                labelResult.text = result
            }
            function onGetCounter(counter){
                labelScoreTxt.visible = true
                labelScore.visible = true
                labelScore.text = counter
            }
            function onGetMsg(msg){
                labelMsg.text = msg
            }
            function onGetTopScore(msgrecord){
                var splits = msgrecord.split('|');
                first.text = splits[0];
                second.text = splits[1];
                third.text = splits[2];
                fourth.text = splits[3];
                fifth.text = splits[4];
                sixth.text = splits[5];
                seventh.text = splits[6];
                eighth.text = splits[7];
                ninth.text = splits[8];
                tenth.text = splits[9];
            }
        }

        Label {
            id: labelTextName
            color: "#ffffff"
            text: qsTr("Label")
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 36
            opacity: 0
            visible: false

            SequentialAnimation {
                id: animationlabelTextName
                NumberAnimation{
                    id: numberAnimation
                    target: labelTextName
                    property: "opacity"
                    to: 1
                    duration: 1500
                }
                PauseAnimation {
                    duration: 1000
                }
                NumberAnimation{
                    target: labelTextName
                    property: "opacity"
                    to: 0
                    duration: 1500
                }
            }
        }

        Rectangle {
            id: endGameRecordsTable
            color: "#f105222e"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: topBar.bottom
            anchors.bottom: parent.bottom
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.bottomMargin: 0
            anchors.topMargin: 0
            opacity: 0.9
            visible: false

            Label {
                id: labelMsg
                height: 31
                color: "#1c1c1c"
                text: qsTr("Label")
                anchors.left: parent.horizontalCenter
                anchors.right: parent.horizontalCenter
                anchors.top: parent.top
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                font.pointSize: 32
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 20
            }

            Column {
                id: column
                width: 600
                height: 500
                anchors.top: labelTable.bottom
                spacing: 6
                anchors.topMargin: 0
                anchors.horizontalCenter: parent.horizontalCenter

                Label {
                    id: first
                    height: 45
                    color: "#ffffff"
                    text: qsTr("Label")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 270
                    font.pointSize: 16
                    font.underline: true
                    font.italic: false
                }

                Label {
                    id: second
                    height: 45
                    color: "#ffffff"
                    text: qsTr("Label")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: first.bottom
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 270
                    font.pointSize: 16
                    anchors.topMargin: 5
                    font.underline: true
                    font.italic: false
                }

                Label {
                    id: third
                    height: 45
                    color: "#ffffff"
                    text: qsTr("Label")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: second.bottom
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 270
                    font.pointSize: 16
                    anchors.topMargin: 5
                    font.underline: true
                    font.italic: false
                }

                Label {
                    id: fourth
                    height: 45
                    color: "#ffffff"
                    text: qsTr("Label")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: third.bottom
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 270
                    font.pointSize: 16
                    anchors.topMargin: 5
                    font.underline: true
                    font.italic: false
                }

                Label {
                    id: fifth
                    height: 45
                    color: "#ffffff"
                    text: qsTr("Label")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: fourth.bottom
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 270
                    font.pointSize: 16
                    anchors.topMargin: 5
                    font.underline: true
                    font.italic: false
                }

                Label {
                    id: sixth
                    height: 45
                    color: "#ffffff"
                    text: qsTr("Label")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: fifth.bottom
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 270
                    font.pointSize: 16
                    anchors.topMargin: 5
                    font.underline: true
                    font.italic: false
                }

                Label {
                    id: seventh
                    height: 45
                    color: "#ffffff"
                    text: qsTr("Label")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: sixth.bottom
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 270
                    font.pointSize: 16
                    anchors.topMargin: 5
                    font.underline: true
                    font.italic: false
                }

                Label {
                    id: eighth
                    height: 45
                    color: "#ffffff"
                    text: qsTr("Label")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: seventh.bottom
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 270
                    font.pointSize: 16
                    anchors.topMargin: 5
                    font.underline: true
                    font.italic: false
                }

                Label {
                    id: ninth
                    height: 45
                    color: "#ffffff"
                    text: qsTr("Label")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: eighth.bottom
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 16
                    anchors.topMargin: 5
                    anchors.leftMargin: 270
                    font.underline: true
                    font.italic: false
                }

                Label {
                    id: tenth
                    height: 45
                    color: "#ffffff"
                    text: qsTr("Label")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: ninth.bottom
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 270
                    font.pointSize: 16
                    anchors.topMargin: 5
                    font.underline: true
                    font.italic: false
                }
            }

            Label {
                id: labelTable
                color: "#707070"
                text: qsTr("Таблица лидеров ")
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: labelMsg.bottom
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 24
                anchors.rightMargin: 604
                anchors.leftMargin: 640
                anchors.topMargin: 15
            }

        }

        Frame {
            id: frameRes
            width: 360
            height: 369
            visible: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            background: Rectangle{
                color: "#ffa640"
                radius: 15

            }

            Label {
                id: labelResult
                width: 360
                height: 92
                visible: false
                color: "#331e00"
                text: qsTr("Label")
                anchors.top: parent.top
                horizontalAlignment: Text.AlignHCenter
                anchors.topMargin: 50
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 40
            }

            Label {
                id: labelScoreTxt
                y: 314
                visible: false
                color: "#331e00"
                text: qsTr("Очки:")
                anchors.left: parent.left
                anchors.top: labelResult.top
                anchors.leftMargin: 128
                anchors.topMargin: 80
                font.pointSize: 20
            }

            Label {
                id: labelScore
                x: 288
                y: 351
                width: 64
                height: 37
                visible: false
                color: "#331e00"
                text: qsTr("Label")
                anchors.left: labelScoreTxt.left
                anchors.top: labelResult.top
                anchors.topMargin: 80
                font.pointSize: 20
                anchors.leftMargin: 77
            }

            StartButton {
                id: endGameButton
                y: 292
                height: 53
                text: "Завершить"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.rightMargin: 43
                anchors.leftMargin: 43
                anchors.bottomMargin: 0
                onClicked:{
                    frameRes.visible = false
                    robotScissors.anchors.rightMargin = -400
                    robotRock.anchors.rightMargin = -400
                    robotPaper.anchors.rightMargin = -400
                    humanRock.x = -400
                    humanPaper.x = -400
                    humanScissors.x = -400
                    endGameRecordsTable.visible = true
                    rockBtn.visible = false
                    scissorsBtn.visible = false
                    paperBtn.visible = false
                    backend.counterToDB(labelScore.text)
                    backend.sendRecordTable(true)
                }
            }
        }

        Label {
            id: label
            x: 515
            color: "#ffffff"
            y: 485
            text: qsTr("Label")
        }







    }
}


/*##^##
Designer {
    D{i:0;formeditorZoom:0.02}
}
##^##*/
