## Parsing

function parse_crates(input)
    lines = split(input, '\n')
    stacks = [Char[] for _ in 1:(length(first(lines))+1)÷4]
    for line in reverse(lines), j in findall(in('A':'Z'), line)
        push!(stacks[1+div(j-2, 4)], line[j])
    end
    return stacks
end

function parse_instructions(input)
    parse_line(line) = parse.(Int, match(r"move (\d+) from (\d+) to (\d+)", line).captures)
    return [parse_line(line) for line in split(input, '\n')]
end

parse_both(input) = (parse_crates(input[1]), parse_instructions(input[2]))
stacks, instructions = split(read("input.txt", String), "\n\n") |> parse_both

## Solution

function follow_instructions1!(stacks, instructions)
    for (N, src, dest) in instructions
        for _ in 1:N push!(stacks[dest], pop!(stacks[src])) end
    end
    return stacks
end

function follow_instructions2!(stacks, instructions)
    crane = Char[]
    for (N, src, dest) in instructions
        for _ in 1:N push!(crane, pop!(stacks[src])) end
        for _ in 1:N push!(stacks[dest], pop!(crane)) end
    end
    return stacks
end

ans₁ = follow_instructions1!(deepcopy(stacks), instructions) .|> last |> String
ans₂ = follow_instructions2!(deepcopy(stacks), instructions) .|> last |> String
