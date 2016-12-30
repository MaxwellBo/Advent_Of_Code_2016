# http://adventofcode.com/2016/day/12

# Day 12 = v0
# Day 23 = v1

def main(day, part):
    with open("inputs/Day_{}_input.txt".format(day)) as fp:

        # Parse input
        program = [ i.split() for i in fp.read().split("\n") ]

        # Build computer
        pc = 0
        registers = { "a": 0
                    , "b": 0
                    , "c": 0 if day == 12 and part == 1 else 1
                    , "d": 0
                    }

        # Run program
        while pc < len(program):
            ins = program[pc]

            # Takes one l-value, and one r-value
            if ins[0] == "cpy":
                val = int(ins[1]) if ins[1].isdigit() else registers[ins[1]]
                try:
                    registers[ins[2]] = val
                except:
                    pass

            # Takes one l-value
            elif ins[0] == "inc":
                registers[ins[1]] += 1

            # Takes one l-value
            elif ins[0] == "dec":
                registers[ins[1]] -= 1

            # Takes two l/r-values
            elif ins[0] == "jnz":
                test = int(ins[1]) if ins[1].isdigit() else registers[ins[1]]
                jump = int(ins[2]) if ins[2].lstrip('-').isdigit() else registers[ins[2]]

                if test: 
                    pc += jump - 1

            elif ins[0] == "tgl":
                i = pc + registers[ins[1]]
                
                if len(program[i]) == 2:
                    if program[i][0] == "inc":
                        program[i][0] = "dec"
                    else:
                        program[i][0] = "inc"
                else:
                    if program[i][0] == "jnz":
                        program[i][0] = "cpy"
                    else:
                        program[i][0] = "jnz"


            pc += 1
        else:
            print(registers) # P1 


if __name__ == '__main__':
    main(12, 1) # a: 318020
    main(12, 2) # a: 9227674
    main(23, 1)
