# http://adventofcode.com/2016/day/2

numpad = [
            [1, 2, 3], 
            [4, 5, 6], 
            [7, 8, 9]
        ]


x, y = (1, 1) # Coords of 5

code = []

def parse_move(char):
    
    global x
    global y

    if char == "U":
        y -= 1
    elif char == "D":
        y += 1
    elif char == "L":
        x -= 1
    elif char == "R":
        x += 1

    if x > 2:
        x = 2
    elif x < 0:
        x = 0

    if y > 2:
        y = 2
    elif y < 0:
        y = 0

def record_digit():
    code.append(numpad[y][x])

if __name__ == "__main__":
    with open("inputs/Day_2_input.txt") as fp:
        for row in fp:
            for instruction in row:
                parse_move(instruction)

            record_digit()

    print(code) # 61529
    
