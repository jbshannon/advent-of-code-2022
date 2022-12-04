paired = map(readlines("input.txt")) do pair
    map(split(pair, ',')) do assignment
        L, R = split(assignment, '-') .|> Base.Fix1(parse, Int)
        return L:R
    end
end

either_contains(p) = ((a, b) = p; (a ⊆ b) | (a ⊇ b))
overlaps(p) = ((a, b) = p; !isempty(a ∩ b))

ans₁ = sum(either_contains, paired)
ans₂ = sum(overlaps, paired)
