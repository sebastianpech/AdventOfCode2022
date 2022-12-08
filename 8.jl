using DelimitedFiles
parse_input(file) = parse.(Int,permutedims(reduce(hcat,split.(readlines(file),Ref("")))))

# Part 1
function all_smaller(trees, (r,c), (dr,dc))
    tr = r
    tc = c
    while 0 < (tr = tr+dr) <= size(trees,1) && 0 < (tc = tc+dc) <= size(trees,2)
        if trees[tr,tc] >= trees[r,c]
            return false
        end
    end
    return true
end

t = parse_input("8.input")
count(any(all_smaller(t, (r,c), dx) for dx in [(0,1),(0,-1),(1,0),(-1,0)]) for r in 1:size(t,1) for c in 1:size(t,2))

# Part 2
function count_smaller(trees, (r,c), (dr,dc))
    tr = r
    tc = c
    count = 0 
    while 0 < (tr = tr+dr) <= size(trees,1) && 0 < (tc = tc+dc) <= size(trees,2)
        count += 1
        if trees[tr,tc] >= trees[r,c]
            return count
        end
    end
    return count
end

maximum([prod(count_smaller(t, (r,c), dx) for dx in [(0,1),(0,-1),(1,0),(-1,0)]) for r in 1:size(t,1) for c in 1:size(t,2)])
