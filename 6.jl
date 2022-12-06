input = read("6.input", String)

# Part 1
findfirst(x->length(Set(x)) == 4,(@view input[i:i+3] for i in 1:length(input)-3))+3

# Part 2
findfirst(x->length(Set(x)) == 14,(@view input[i:i+13] for i in 1:length(input)-13))+13