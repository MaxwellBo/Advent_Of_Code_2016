from collections import defaultdict

class Bot(object):
    def __init__(self):
        self.chips = []
        self.name = ""
        self.high_sink = None
        self.low_sink = None

    def pop_min(self):
        min_val = min(self.chips)
        self.chips.remove(min_val)
        self.low_sink.chips.append(min_val)

    def pop_max(self):
        max_val = max(self.chips)
        self.chips.remove(max_val)
        self.high_sink.chips.append(max_val)
    
    def tick(self):

        if len(self.chips) == 2:
            if 17 in self.chips and 61 in self.chips:
                print(name)

            self.pop_min()
            self.pop_max()

instructions = """value 5 goes to bot 2
bot 2 gives low to bot 1 and high to bot 0
value 3 goes to bot 1
bot 1 gives low to output 1 and high to bot 0
bot 0 gives low to output 2 and high to output 0
value 2 goes to bot 2"""

with open("Day_10_input.txt") as fp:

    graph = defaultdict(Bot)

    for line in instructions.split('\n'):

        tokens = line.split()

        print(tokens)

        if tokens[0] == "value":
            name = tokens[-2] + tokens[-1]
            graph[name].chips.append(int(tokens[1]))
            graph[name].name = name

        elif tokens[0] == "bot":
            target_name = tokens[0] + tokens[1]
            low_name = tokens[5] + tokens[6]
            high_name = tokens[-2] + tokens[-1]

            graph[target_name].low_sink = graph[low_name]
            graph[target_name].high_sink = graph[high_name]

            graph[target_name].name = target_name
            graph[low_name].name = low_name
            graph[high_name].name = high_name


    for i in range(1, 1000):
        for (k, v) in graph.items():
            v.tick()
