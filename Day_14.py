# http://adventofcode.com/2016/day/14

import hashlib

class Candidate(object):
    def __init__(self, char, stamp):
        self.char = char
        self.stamp = stamp
        self.alive = True

def main():

    queue = []
    index = 0
    keys = 0

    while True:

        word = ("qzyelonm{}".format(index)).encode('utf-8')

        m = hashlib.md5()
        m.update(word)
        hash_result = m.hexdigest()

        # Kill expired candidates
        queue = [ i for i in queue if i.stamp + 1000 >= index if i.alive ]

        for i in queue:
            if i.char in quintuplets(hash_result):
                keys += 1
                i.alive = False

                print(index, keys)
                if keys == 64:
                    return


        triplet = first_triplet(index, hash_result)
        if triplet:
            queue.append(triplet)

        index += 1

def substrings_of_length(n, xs):
    return (xs[i:n + i] for i in range(len(xs) + 1 - n))

def first_triplet(stamp, xs):
    for i in substrings_of_length(3, xs):
        if i == 3 * i[0]:
            return Candidate(i[0], stamp)

    return None

def quintuplets(xs):
    return (i[0] for i in substrings_of_length(5, xs) if i == 5 * i[0])

if __name__ == '__main__':
    main() 