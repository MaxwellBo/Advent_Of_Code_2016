from itertools import *
from itertools_recipes import *

with open("Day_3_1_input.txt") as fp:
    
    split_lines = [line.split() for line in fp]

    groups_of_three_lines = grouper(split_lines, 3, [])

    rotated_three_lines = [zip(*three_lines[::-1]) for three_lines in groups_of_three_lines]
    
    triangles =  [[ int(side) for side in triangle ] for triangle in flatten(rotated_three_lines) ]

    def is_possible(t):
        return t[0] + t[1] > t[2] and t[1] + t[2] > t[0] and t[2] + t[0] > t[1]

    possible = sum(is_possible(triangle) for triangle in triangles) 
    print(possible)

