# http://adventofcode.com/2016/day/3

from itertools import *
from itertools_recipes import *

def is_possible(t):
    return t[0] + t[1] > t[2] and t[1] + t[2] > t[0] and t[2] + t[0] > t[1]

def main(part):
	with open("inputs/Day_3_input.txt") as fp:
	    
	    if part == 1:
	    	triangles = [ [ int(side) for side in line.split() ] for line in fp ]
	    else:
		    split_lines = [ line.split() for line in fp ]

		    groups_of_three_lines = grouper(split_lines, 3, [])

		    rotated_three_lines = [ zip(*three_lines[::-1]) for three_lines in groups_of_three_lines ]
		    
		    triangles = [ [ int(side) for side in triangle ] for triangle in flatten(rotated_three_lines) ]

	    possible = sum(is_possible(triangle) for triangle in triangles) 

	    print(possible) # P1: 1032, P2: 1838

if __name__ == '__main__':
	main(1)
	main(2)
