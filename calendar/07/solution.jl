const dirstack = String[]
const children = Dict("/" => String[])
const contents = Dict("/" => Int[])

_cd(dir) = dir == ".." ? pop!(dirstack) : push!(dirstack, dir)

function _ls(line)
    cwd = joinpath(dirstack...)
    children[cwd] = String[]
    contents[cwd] = String[]
    for l in split(line, '\n')
        if startswith(l, "dir ")
            push!(children[cwd], joinpath(cwd, l[5:end]))
        elseif startswith(l, r"\d")
            push!(contents[cwd], parse(Int, first(split(l))))
        end
    end
end

dirsize(dir) = sum(contents[dir]; init=0) + sum(dirsize, children[dir]; init=0)

function parse_input(input)
    cmds = split(read(input, String), "\$ "; keepempty=false)
    for cmd in cmds
        if startswith(cmd, "cd")
            _cd(strip(cmd[4:end]))
        elseif startswith(cmd, "ls")
            _ls(cmd[3:end])
        end
    end
end

parse_input("input.txt")
dirsizes = [dirsize(k) for k in keys(children)]

ans₁ = filter(<=(100000), dirsizes) |> sum
ans₂ = filter(>=(30000000 - (70000000 - dirsize("/"))), dirsizes) |> minimum
@info "Solution to Day 7" ans₁ ans₂
