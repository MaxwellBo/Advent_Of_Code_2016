# http://adventofcode.com/2016/day/12

def main(part):
    with open("inputs/Day_12_input.txt") as fp:

        instructions = fp.read().split("\n")

        pc = 0

        registers = { "a": 0
                    , "b": 0
                    , "c": 0 if part == 1 else 1
                    , "d": 0
                    }

        while pc < len(instructions):
            tokens = instructions[pc].split()

            if tokens[0] == "cpy":
                if tokens[1].isdigit():
                    registers[tokens[2]] = int(tokens[1])
                else:
                    registers[tokens[2]] = registers[tokens[1]]

                pc += 1
            elif tokens[0] == "inc":
                registers[tokens[1]] += 1
                pc += 1
            elif tokens[0] == "dec":
                registers[tokens[1]] -= 1
                pc += 1
            elif tokens[0] == "jnz":
                if tokens[1].isdigit():
                    if int(tokens[1]) != 0:
                        pc += int(tokens[2]) - 1 
                else: 
                    if registers[tokens[1]] != 0:
                        pc += int(tokens[2]) - 1
                
                pc += 1

        print(registers) # P1 


if __name__ == '__main__':
    main(1) # a: 318020
    main(2) # a: 9227674

x = 5