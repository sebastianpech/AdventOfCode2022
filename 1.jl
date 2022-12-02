parse_input(input) = map(x->parse.(Int,x),split.(split(input, "\n\n"), Ref("\n"), keepempty=false))

# Part 1
maximum(sum.(parse_input(read("1.input",String))))

# Part 2
sum(sort(sum.(parse_input(read("1.input",String))))[end-2:end])

