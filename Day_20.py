from itertools_recipes import *
from itertools import *

class Range(object):
    def __init__(self, lower, upper):
        self.upper = upper
        self.lower = lower
        self.alive = True

    def __contains__(self, item):
        return self.lower - 1 <= item <= self.upper + 1

    def __repr__(self):
        return f"Range({self.lower}, {self.upper})"

def merge(a, b):
    if a.alive and b.alive:
        xs = (a.lower in b, a.upper in b, b.lower in a, b.upper in a)

        if xs == (0, 0, 1, 1):
            b.alive = False
        elif xs == (1, 1, 0, 0):
            a.alive = False
        elif xs == (0, 1, 1, 0):
            a.upper = b.upper
            b.alive = False
        elif xs == (1, 0, 0, 1):
            b.upper = a.upper
            a.alive = False


def main():
    with open("inputs/Day_20_input.txt") as fp:
        disallowed = []
        
        for line in fp:
            lower, upper = line.split('-')
            disallowed.append(Range(int(lower), int(upper)))


        for i in range(1, 20):
            print(len(disallowed))

            for a, b in combinations(disallowed, 2):
                merge(a, b)

            disallowed = [ i for i in disallowed if i.alive ]

        disallowed.sort(key=lambda x: x.lower)

        print(disallowed[0].upper + 1) # Part One: 22887907

if __name__ == '__main__':
    main() # 22887906