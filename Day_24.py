import networkx as nx
from itertools import *

def main():

    with open("inputs/Day_24_input.txt") as fp:
    # with open("sample.txt") as fp:
        m = [ i.strip() for i in fp ]

        rows = len(m)
        cols = len(m[0])
        pois_to_node = {}

        g = nx.grid_2d_graph(m=cols, n=rows)

        for y in range(rows):
            for x in range(cols):
                if m[y][x] == '#':
                    g.remove_node((x, y))
                elif m[y][x].isdigit():
                    pois_to_node[int(m[y][x])] = (x, y)

        h = nx.Graph()
        adjacency = []


        for (start_name, start_pos) in pois_to_node.items():
            for (finish_name, finish_pos) in pois_to_node.items():

                weight = nx.astar_path_length(g, start_pos, finish_pos)
                adjacency.append((start_name, finish_name, weight))

        #         if start_name == finish_name:
        #             continue

        #         print(start_name, finish_name, weight)

                # h.add_edge(start_name, finish_name, weight=weight) 

        # print(nx.single_source_dijkstra_path_length(h, '0'))

        all_pois = {i for i in range(1, len(pois_to_node))}

        def is_hamiltonian_path(xs):
            starts_at_zero = xs[0][0] == 0
            valid = all(xs[i][1] == xs[i + 1][0] for i in range(len(xs) - 1))
            path = {i[1] for i in xs} == all_pois
            return starts_at_zero and valid and path

        def length(xs):
            return sum(i[2] for i in xs)

        perms = permutations(adjacency, len(pois_to_node) - 1)

        valid_perms = filter(is_hamiltonian_path, perms)

        lowest = 10000000000000000000000000
        for i in valid_perms:
            if length(i) < lowest:
                lowest = length(i)

        print(lowest)

if __name__ == '__main__':
    main()


