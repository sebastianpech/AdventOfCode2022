mutable struct Monkey
    items::Vector{Int64}
    operation::Function
    test::Int
    true_monkey::Int
    false_monkey::Int
    inspect_count::Int
end

re_mon = r"Monkey (\d+).*\n.*Starting items: ([\d, ]+)\n.*Operation: new = ([^\n]*)\n.*Test: divisible by (\d+)\n.*If true: throw to monkey (\d+)\n.*If false: throw to monkey (\d+)"

function turn(monkeys, n)
    m = monkeys[n+1]
    map!(m.items,m.items) do itm
        m.inspect_count += 1
        Int.(floor(m.operation(itm)/3))
    end
    for i in copy(m.items)
        if i % m.test == 0
            push!(monkeys[m.true_monkey+1].items, popfirst!(m.items))
        else
            push!(monkeys[m.false_monkey+1].items, popfirst!(m.items))
        end
    end
end

function mround(monkeys)
    for i in 0:length(monkeys)-1
        turn(monkeys, i)
    end
end

monkeys = map(eachmatch(re_mon,read("11.input", String))) do m
    Monkey(parse.(Int,split(m[2], ",")),
    eval(Meta.parse("old->"*m[3])),
    parse(Int,m[4]), parse(Int,m[5]), parse(Int,m[6]), 0)
end

for i in 1:20
    mround(monkeys)
end

prod(sort((x->x.inspect_count).(monkeys))[end-1:end])

# Part 2

struct Item
    vMonkey::Dict{Int64,Int64}
end

mutable struct Monkey2
    items::Vector{Item}
    operation::Function
    test::Int
    true_monkey::Int
    false_monkey::Int
    inspect_count::Int
end

function turn2(monkeys, n)
    m = monkeys[n+1]
    for itm in copy(m.items)
        m.inspect_count += 1
        for _m in keys(itm.vMonkey)
            itm.vMonkey[_m] = m.operation(itm.vMonkey[_m]) % monkeys[_m+1].test
        end
        if itm.vMonkey[n] == 0
            push!(monkeys[m.true_monkey+1].items, popfirst!(m.items))
        else
            push!(monkeys[m.false_monkey+1].items, popfirst!(m.items))
        end
    end
end

function mround2(monkeys)
    for i in 0:length(monkeys)-1
        turn2(monkeys, i)
    end
end

create_item(monkeys,itm) = Item(Dict(i-1=>itm for i in eachindex(monkeys)))
monkeys2 = map(eachmatch(re_mon,read("11.input", String))) do m
    Monkey2(create_item.(Ref(monkeys),parse.(Int,split(m[2], ","))),
    eval(Meta.parse("old->"*m[3])),
    parse(Int,m[4]), parse(Int,m[5]), parse(Int,m[6]), 0)
end

for i in 1:10000
    mround2(monkeys2)
end


prod(sort((x->x.inspect_count).(monkeys2))[end-1:end])