function parse_input(io)
    lines = readlines(io)
    I, J = length(lines), length(first(lines))
    out = zeros(Int8, I, J)
    for i in 1:I, j in 1:J
        out[i, j] += lines[i][j] - '0'
    end
    return out
end

const forest = parse_input("input.txt")
const I, J = size(forest)

𝐋(i) = i-I
𝐑(i) = i+I < I*J ? i+I : 0
𝐃(i) = i%J > 0 ? i+1 : 0
𝐔(i) = (i-1)%J > 0 ? i-1 : 0

isvisible(i, D, h) = D(i) < 1 ? true : (forest[D(i)] < h) && isvisible(D(i), D, h)
isvisible(i, D) = isvisible(i, D, forest[i])
# isvisible(i) = any(Base.Fix1(isvisible, i), (𝐋, 𝐑, 𝐃, 𝐔))
isvisible(i) = isvisible(i, 𝐋) || isvisible(i, 𝐑) || isvisible(i, 𝐃) || isvisible(i, 𝐔)

function treesviewed(i, D)
    n, h = 0, forest[i]
    while true
        i = D(i) # move in the given direction
        i < 1 && break # stop counting if we have moved outside the grid
        n += 1 # add to the count of visible trees
        forest[i] >= h && break # stop counting if the view is blocked
    end
    return n
end
# scenicscore(i) = prod(Base.Fix1(treesviewed, i), (𝐋, 𝐑, 𝐃, 𝐔))
scenicscore(i) = treesviewed(i, 𝐋) * treesviewed(i, 𝐑) * treesviewed(i, 𝐃) * treesviewed(i, 𝐔)

ans₁ = count(isvisible, eachindex(forest))
ans₂ = maximum(scenicscore, eachindex(forest))
@info "Solution to Day 8" ans₁ ans₂
