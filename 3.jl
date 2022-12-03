item_priority(c) = isuppercase(c) ?  Int(c)-38 : Int(c)-96

# Part 1
sum(map(readlines("3.input")) do line
    Iterators.partition(line,length(line)÷2) |> collect .|> Set |> (x->∩(x...)) |> only |> item_priority
end)

# Part 2
sum(map(Iterators.partition(readlines("3.input"),3)) do (a,b,c)
    item_priority(only(a ∩ b ∩ c))
end)
