mutable struct State
    register::Int
    cycle::Int
    cycles::Dict{Int, Int}
end

function command!(s,::Val{:noop})
    s.cycle += 1
    s.cycles[s.cycle] = s.register
end
function command!(s,::Val{:addx},x) 
    s.cycles[s.cycle+1] = s.register
    s.register += x
    s.cycle += 2
    s.cycles[s.cycle] = s.register
end

s = State(1,0,Dict{Int,Int}(0=>1))
for line in readlines("10.input")
    if line == "noop"
        command!(s,Val(:noop))
    else
        command!(s,Val(:addx),parse(Int,line[5:end]))
    end
end

# Part 1
s.cycles[19]*20+s.cycles[59]*60+ s.cycles[99]*100+ s.cycles[139]*140+ s.cycles[179]*180+s.cycles[219]*220

# Part 2
for r in 1:6
    for c in 1:40
        cycle = (r-1)*40+c
        if abs(s.cycles[cycle-1] - (c-1)) <= 1
            print("#")
        else
            print(".")
        end
    end
    println()
end

