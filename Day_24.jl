# http://adventofcode.com/2016/day/24

importall LightGraphs



function main()

    p2m = Dict()
    m2p = Dict()
    p2e = Dict()

    e = 0 # edge

    open("sample.txt") do file
        for (x, i) in enumerate(eachline(file))
            for (y, j) in enumerate(i[1:end - 1]) # Cull newlines
                e += 1
                p2m[(x, y)] = j # Point to map spot
                p2e[(x, y)] = e # Point to graph edge

                if isdigit(j)
                    m2p[j] = (x, y) # Locations of cities
                end
            end
        end
    end

    

    g = Graph(e)

    for ((x, y), m) in p2m
        if m != '#' # if this is an empty space

            this_edge = p2e[(x, y)]

            for p in [(x, y - 1), (x, y + 1), (x - 1, y), (x + 1, y)]
                m = get!(p2m, p, nothing)
                if !(m == nothing || m == "#") # and the other is an empty space
                    other_edge = p2e[p]
                    add_edge!(g, this_edge, other_edge)
                end
            end
        end
    end

    function m2e(m)
        return p2e[m2p[m]]
    end

    distances = []

    for start in keys(m2p)
        for finish in keys(m2p)
            distance = length(a_star(g, m2e(start), m2e(finish)))
            push!(distances, (start, distance, finish))
        end
    end

    print(distances)


end

main()
