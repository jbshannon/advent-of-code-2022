elves = split(read("input.txt", String), "\n\n")
calories = map(elves) do elf
    sum(Base.Fix1(parse, Int), split(elf, '\n'))
end
sort!(calories, rev=true)

ans₁ = calories[1]
ans₂ = calories[1:3] |> sum
@info "Solution to Day 1" ans₁ ans₂
