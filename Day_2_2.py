# http://adventofcode.com/2016/day/2

numpad = [ "  1  ",
           " 234 ",
           "56789",
           " ABC ",
           "  D  "
         ]

x, y = (0, 2) # Coords of 5


code = []

def parse_move(char):
    
    global x
    global y

    old_x = x
    old_y = y

    if char == "U":
        y -= 1
    elif char == "D":
        y += 1
    elif char == "L":
        x -= 1
    elif char == "R":
        x += 1

    if x > 4:
        x = 4
    elif x < 0:
        x = 0

    if y > 4:
        y = 4
    elif y < 0:
        y = 0

    if numpad[y][x] == ' ':
        x = old_x
        y = old_y
        return
     
def record_digit():
    code.append(numpad[y][x])

if __name__ == "__main__":
    with open("Day_2_input.txt") as fp:
        for row in fp:
            for instruction in row:
                parse_move(instruction)

            record_digit()

    print(code)
    
