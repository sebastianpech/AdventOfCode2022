to_abs_folder(cwd) = [join(cwd[1:i], "/") for i in eachindex(cwd)]

function folder_sizes(file)
    directory_size = Dict{String, Int}()
    cwd = String[]
    cc = ""
    for line in readlines(file)
        if startswith(line, "\$")
            _cc = split(line, " ")
            cc = _cc[2]
            if cc == "cd"
                if _cc[3] == ".."
                    pop!(cwd)
                elseif _cc[3] == "/"
                    cwd = ["/"]
                else
                    push!(cwd, _cc[3])
                end
                continue
            end
        elseif cc == "ls"
            if !(startswith(line, "dir"))
                s, _ = split(line, " ")
                for dir in to_abs_folder(cwd)
                    directory_size[dir] = get(directory_size, dir, 0) + parse(Int, s)
                end
            end
        end
    end
    return directory_size
end

# Part 1

sum(filter(<=(100000),collect(values(folder_sizes("7.input")))))

# Part 2

sizes = folder_sizes("7.input")
minimum(filter(>=(sizes["/"]-40000000),collect(values(sizes))))

