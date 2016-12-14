# http://adventofcode.com/2016/day/6

from collections import Counter

with open("Day_6_1_input.txt") as fp:
    rotated_message = [  "".join(char) for char in zip(*fp.read().split()[::-1]) ]

    # for least common, change the following index to -1
    #                                                     v
    error_corrected = "".join(Counter(line).most_common()[-1][0] for line in rotated_message)

    print(error_corrected)

