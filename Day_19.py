from collections import deque

def main(part):

    elfs = deque(i for i in range(1, 5 + 1))

    while True:

        # What goes on the end
        x = elfs.popleft()

        # The one we're taking
        elfs.popleft()

        # What we're putting on the end
        elfs.append(x)

        print(len(elfs))

        if len(elfs) == 1:
            print(elfs[0])
            return

if __name__ == '__main__':
    main(1)