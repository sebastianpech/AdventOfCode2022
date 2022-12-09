function move!(head, tail)
    Δtail = head-tail
    if !all(<=(1), abs.(Δtail))
        tail .+= sign.(Δtail)
    end
    nothing
end

directions = Dict("R"=>[1,0], "L"=>[-1,0], "U"=>[0,1], "D"=>[0,-1])

# Part 1
head = [0,0]
tail = [0,0]
positions = Set{Tuple{Int,Int}}()
for com in readlines("9.input")
    _Δd, no = split(com, " ")
    Δd = directions[_Δd]
    for i in 1:parse(Int, no)
        head .+= Δd
        move!(head, tail)
        push!(positions, (tail...,))
    end
end
length(positions)

# Part 2
head = [0,0]
tail = [[0,0] for _ in 1:9]
positions = Set{Tuple{Int,Int}}()
for com in readlines("9.input")
    _Δd, no = split(com, " ")
    Δd = directions[_Δd]
    for i in 1:parse(Int, no)
        head .+= Δd
        move!(head, tail[1])
        for j in 2:9
            move!(tail[j-1], tail[j])
        end
        push!(positions, (tail[end]...,))
    end
end
length(positions)
