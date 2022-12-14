using Graphs

hmap = mapreduce(permutedims,vcat,map(x->map(x->Int(x[1]),split(x,"")),readlines("12.input")))

to_linear_index(A, i, j) = (i-1)*size(A,2)+j

idxS = only(findall(==(Int('S')), hmap))
idxE = only(findall(==(Int('E')), hmap))

hmap[idxS] = Int('a')
hmap[idxE] = Int('z')

g = SimpleDiGraph(length(hmap))
for i in axes(hmap,1)
    for j in axes(hmap,2)
        node = to_linear_index(hmap, i, j)
        for (di, dj) in ((0,1), (0,-1), (1,0), (-1,0))
            if 1 ≤ i+di ≤ size(hmap,1) && 1 ≤ j+dj ≤ size(hmap,2)
                if hmap[i+di,j+dj] - hmap[i,j] ≤ 1
                    node2 = to_linear_index(hmap, i+di, j+dj)
                    add_edge!(g, node, node2)
                end
            end
        end
    end
end

has_path(g, to_linear_index(hmap, idxS[1], idxS[2]), to_linear_index(hmap, idxE[1], idxE[2]+12))

ds = dijkstra_shortest_paths(g, to_linear_index(hmap, idxS[1], idxS[2]))
ds.dists[to_linear_index(hmap, idxE[1], idxE[2])]

# Part 2

minimum(map(findall(==(Int('a')), hmap)) do i
    idx = to_linear_index(hmap, i[1], i[2])
    ds = dijkstra_shortest_paths(g, idx)
    ds.dists[to_linear_index(hmap, idxE[1], idxE[2])]
end)