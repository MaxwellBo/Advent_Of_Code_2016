# http://adventofcode.com/2016/day/5

import hashlib

def main():

	index = 0
	answer = ['?'] * 8

	while True:

		word = ("uqwqemis{}".format(index)).encode('utf-8')

		m = hashlib.md5()
		m.update(word)
		hash_result = m.hexdigest()

		if hash_result[0:5] == '00000':
			print(hash_result)

			try:
				if answer[int(hash_result[5])] == '?':
					answer[int(hash_result[5])] = hash_result[6]
			except:
				pass

			print(answer)

		index += 1

if __name__ == '__main__':
	main()