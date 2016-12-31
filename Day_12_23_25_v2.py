# IMPORTANT: Must be run with Python 2.7

# http://adventofcode.com/2016/day/12
# http://adventofcode.com/2016/day/23
# http://adventofcode.com/2016/day/25

from __future__ import absolute_import, division, print_function

cpy = "{2} = {1}"
inc = "{1} += 1"
dec = "{1} -= 1"
jnz = "pc += ({2} - 1 if {1} else 0)"
tgl = "if pc + {1} < len(program): program[pc + {1}][0] = ct[program[pc + {1}][0]]"
out = "clock.append({1})"

def main(day, a_p=0, c_p=0):
    with open("inputs/Day_{}_input.txt".format(day)) as fp:

        # Parse input
        program = [ i.split() for i in fp.read().split("\n") ]

        # Build computer
        pc = 0

        a = a_p
        b = 0
        c = c_p
        d = 0

        clock = [1]

        ct = { "inc": "dec" # One arg
             , "dec": "inc"
             , "out": "inc"
             , "tgl": "inc" 
             , "jnz": "cpy" # Two arg
             , "cpy": "jnz"
             }

        while pc < len(program):
            ins = program[pc]

            # Forgive me
            exec(eval(ins[0]).format(*ins))
            pc += 1

            if ins[0] == "out":
                if (not (clock[-1] == 0 or clock[-1] == 1)):
                    return
                elif clock[-1] == clock[-2]:
                    return
                elif len(clock) > 50:
                    print(a_p)
                    exit()

        else:
            print(a)
            
if __name__ == '__main__':
    main(12) # a: 318020
    main(12, c_p=1) # a: 9227674
    main(23, a_p=7) # a: 11683
    main(23, a=12) # a: 479008243
    
    for i in range(1, 100000):
        main(25, a_p=i) # 158
