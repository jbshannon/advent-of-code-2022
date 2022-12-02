rounds = readlines("input.txt")

decode(round) = (round[1] - 'A', round[3] - 'X')
shoot(me, opponent) = mod(1 + mod(me - opponent, 3), 3)
strategy(outcome, opponent) = mod(opponent + (outcome-1), 3)
score(me, outcome) = 1 + me + 3*outcome

function score1(round)
    opponent, me = decode(round)
    outcome = shoot(me, opponent)
    return score(me, outcome)
end

function score2(round)
    opponent, outcome = decode(round)
    me = strategy(outcome, opponent)
    return score(me, outcome)
end

ans₁ = sum(score1, rounds)
ans₂ = sum(score2, rounds)
@info "Solution to Day 2" ans₁ ans₂
