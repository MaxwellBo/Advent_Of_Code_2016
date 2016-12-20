# http://adventofcode.com/2016/day/3

with open("Day_3_input.txt") as fp:
    
    triangles =  [[ int(side) for side in line.split() ] for line in fp ]

    def is_possible(t):
        return t[0] + t[1] > t[2] and t[1] + t[2] > t[0] and t[2] + t[0] > t[1]

    possible = sum(is_possible(triangle) for triangle in triangles) 
    print(possible)



    
