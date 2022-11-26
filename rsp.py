ROCK_ACTION = 1
SCISSORS_ACTION = 2
PAPER_ACTION = 3

counter = 0

def battle(computer_choice, player_choice):
    global counter
    result = 'Error'
    if computer_choice == player_choice:
        result = 'Ничья!'
    elif computer_choice == ROCK_ACTION:
        if player_choice == SCISSORS_ACTION:
            result = 'Поражение!'
            counter -= 1
        else:
            result = 'Победа!'
            counter += 1
    elif computer_choice == SCISSORS_ACTION:
        if player_choice == ROCK_ACTION:
            result = 'Победа!'
            counter += 1
        else:
            result = 'Поражение!'
            counter -= 1
    elif computer_choice == PAPER_ACTION:
        if player_choice == SCISSORS_ACTION:
            result = 'Победа!'
            counter += 1
        else:
            result = 'Поражение!'
            counter -= 1
    return result, counter

