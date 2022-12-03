rucksacks = readlines("input.txt")

priority(item) = ((d, r) = divrem(item - 'A', 32); 27 + r - 26d)
score(sacks) = intersect(sacks...) |> only |> priority

ans₁ = sum(score ∘ (r -> Iterators.partition(r, length(r)÷2)), rucksacks)
ans₂ = sum(score, Iterators.partition(rucksacks, 3))
