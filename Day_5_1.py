# http://adventofcode.com/2016/day/5

import hashlib

def main():

	index = 0

	while True:

		word = ("uqwqemis{}".format(index)).encode('utf-8')

		m = hashlib.md5()
		m.update(word)
		hash_result = m.hexdigest()

		if hash_result[0:5] == '00000':
			print(hash_result[5])

		index += 1

if __name__ == '__main__':
	main()