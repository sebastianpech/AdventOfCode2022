function parse_input(file)
    data = readlines(file)
    start_commands = findfirst(==(""), data)
    # Get stacks
    stacks = Dict(parse(Int,idx) => Char[] for idx in split(data[start_commands-1], " ", keepempty=false))
    stacks_idx = range(2,step=4,length=length(stacks))
    foreach(data[1:start_commands-2]) do line
        for (idx, val) in enumerate(collect(line[stacks_idx]))
            if val != ' '
                insert!(stacks[idx], 1, val)
            end
        end
    end
    max_size = sum(length.(values(stacks)))
    sizehint!.(values(stacks), Ref(max_size))
    # Get commands
    stacks, map(data[start_commands+1:end]) do line
        _line = split(line, " ")
        (from=parse(Int, _line[4]), to=parse(Int, _line[6]), n=parse(Int, _line[2]))
    end
end

# Part 1

function run_command!(stack, command)
    for i in 1:command.n
        push!(stack[command.to], pop!(stack[command.from]))
    end
end

stacks, commands = parse_input("5.input")
for command in commands
    run_command!(stacks, command)
end

for i in 1:length(stacks)
    print(stacks[i][end])
end

# Part 2
function run_command_mover_9001!(stack, command)
    temp = [pop!(stack[command.from]) for _ in 1:command.n]
    append!(stack[command.to], reverse(temp))
end

stacks, commands = parse_input("5.input")
for command in commands
    run_command_mover_9001!(stacks, command)
end

for i in 1:length(stacks)
    print(stacks[i][end])
end


