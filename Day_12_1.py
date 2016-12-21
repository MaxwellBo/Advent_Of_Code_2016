# http://adventofcode.com/2016/day/12

instructions = """cpy 1 a
cpy 1 b
cpy 26 d
jnz c 2
jnz 1 5
cpy 7 c
inc d
dec c
jnz c -2
cpy a c
inc a
dec b
jnz b -2
cpy c b
dec d
jnz d -6
cpy 19 c
cpy 11 d
inc a
dec d
jnz d -2
dec c
jnz c -5""".split('\n')

pc = 0

registers = { "a": 0
            , "b": 0
            , "c": 0
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


print(registers) # a: 318020
