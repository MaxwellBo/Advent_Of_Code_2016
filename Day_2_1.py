# http://adventofcode.com/2016/day/2

def main(part):

    x, y = (1, 1) # Coords of 5

    numpad = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]

    def clamp(min_, max_, x):
        return min(max_, max(min_, x))

    with open("inputs/Day_2_input.txt") as fp:

        code = []

        for row in fp:
            for ins in row:
                if ins == "U":
                    y -= 1
                elif ins == "D":
                    y += 1
                elif ins == "L":
                    x -= 1
                elif ins == "R":
                    x += 1

                max_ = 2
                x = clamp(0, max_, x)
                y = clamp(0, max_, y)

            code.append(numpad[y][x])

    print("Part 1:", "".join(str(i) for i in code)) # 61529 

if __name__ == "__main__":
    main(1)

