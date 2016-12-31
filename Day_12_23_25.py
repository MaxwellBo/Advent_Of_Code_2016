# http://adventofcode.com/2016/day/12
# http://adventofcode.com/2016/day/23
# http://adventofcode.com/2016/day/25

def main(day, a_p=0, c_p=0):
    with open("inputs/Day_{}_input.txt".format(day)) as fp:

        # Parse input
        program = [ i.split() for i in fp.read().split("\n") ]

        # Build computer
        pc = 0
        clock = [1]
        registers = { "a": a_p
                    , "b": 0
                    , "c": c_p
                    , "d": 0
                    }

        while pc < len(program):
            ins = program[pc]

            if ins[0] == "cpy":
                val = int(ins[1]) if ins[1].lstrip('-').isdigit() else registers[ins[1]]
                try:
                    registers[ins[2]] = val
                except:
                    pass

            elif ins[0] == "inc":
                registers[ins[1]] += 1

            elif ins[0] == "dec":
                registers[ins[1]] -= 1

            elif ins[0] == "jnz":
                test = int(ins[1]) if ins[1].isdigit() else registers[ins[1]]
                jump = int(ins[2]) if ins[2].lstrip('-').isdigit() else registers[ins[2]]

                if test: 
                    pc += jump - 1

            elif ins[0] == "tgl":
                i = pc + registers[ins[1]]
                
                if i < len(program): 
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

            elif ins[0] == "out":
                clock.append(registers[ins[1]])

                if (not (clock[-1] == 0 or clock[-1] == 1)):
                    return
                elif clock[-1] == clock[-2]:
                    return
                elif len(clock) > 50:
                    print(a_p)
                    exit()

            pc += 1
        else:
            print(registers)
            
if __name__ == '__main__':
    # main(12) # a: 318020
    # main(12, c_p=1) # a: 9227674
    # main(23, a_p=7) # a: 11683
    # main(23, a_p=12) # a: 479008243

    for i in range(1, 100000):
        main(25, a_p=i) # 158

