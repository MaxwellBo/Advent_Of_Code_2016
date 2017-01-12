# http://adventofcode.com/2016/day/5

import hashlib

def main():

    index = 0
    answer = []

    while True:

        word = ("uqwqemis{}".format(index)).encode('utf-8')

        m = hashlib.md5()
        m.update(word)
        hash_result = m.hexdigest()

        if hash_result[0:5] == '00000':
            answer.append(hash_result[5])

            if len(answer) == 8:
                print("Part 1:", "".join(answer))
                exit()

        index += 1

if __name__ == '__main__':
    main() # 1a3099aa