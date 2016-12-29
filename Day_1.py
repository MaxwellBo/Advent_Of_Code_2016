class Person(object):
	def __init__(self):
		self.direction = 0
		self.x = 0
		self.y = 0
		self.locations = set()

	def turn(self, char):
		self.direction += -90 if char == "L" else 90

		if self.direction > 359:
			self.direction -= 360
		elif self.direction < 0:
			self.direction += 360

	def step(self):
		if self.direction == 0:
			self.y += 1
		elif self.direction == 90:
			self.x += 1
		elif self.direction == 180:
			self.y -= 1
		elif self.direction == 270:
			self.x -= 1

	def walk(self, blocks):
		for i in range(0, blocks):
			self.step()

			if (self.x, self.y) in self.locations:
				print("Part Two:", abs(self.x) + abs(self.y)) # 150
			else:
				self.locations.add((self.x, self.y))

def main():

	p = Person()
	crumbs = []

	with open("inputs/Day_1_input.txt") as fp:
		for i in next(fp).split(", "):
			p.turn(i[0])
			p.walk(int(i[1:]))

	print("Part One:", abs(p.x) + abs(p.y)) # 242

if __name__ == '__main__':
	main()