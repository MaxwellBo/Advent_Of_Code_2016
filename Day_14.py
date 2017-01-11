# http://adventofcode.com/2016/day/14

import hashlib
import collections

def hash_(index):
    word = ("abc{}".format(index)).encode('utf-8')

    m = hashlib.md5()
    m.update(word)
    return m.hexdigest()


def main():
    frame = 1001
    # Generates the head, and 1000 other hashes
    queue = collections.deque(hash_(i) for i in range(0, frame))

    keys = 0
    index = 0

    while True:
        triplet_in_head = triplet(queue.popleft())

        if triplet_in_head:
            for h in queue:
                if triplet_in_head in quintuplets(h):
                    keys += 1
                    break

        if keys == 64:
            print(index)
            return

        # Generate the 1001st hash
        queue.append(hash_(index + frame))
        index += 1

def substrings_of_length(n, xs):
    return (xs[i:n + i] for i in range(len(xs) + 1 - n))

def triplet(xs):
    for i in substrings_of_length(3, xs):
        if i == 3 * i[0]:
            return i[0]
    else:
        return None

def quintuplets(xs):
    return (i[0] for i in substrings_of_length(5, xs) if i == 5 * i[0])

if __name__ == '__main__':
    main() 