parse_input(line) = map(r->range(parse.(Int,split(r,"-"))...),split(line, ","))

# Part 1
count(x->x[1] ⊆ x[2] || x[1] ⊇ x[2],parse_input.(readlines("4.input")))

# Part 2
sum(x->length(x[1] ∩ x[2])>0,parse_input.(readlines("4.input")))
