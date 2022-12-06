function countunique!(out, seen, itr)
    empty!(out)
    empty!(seen)
    for x in itr
        if !in(x, seen)
            push!(seen, x)
            push!(out, x)
        end
    end
    return length(out)
end

function read_signal(packet_length)
    out = Set{Char}()
    seen = Set{Char}()
    countunique(itr) = countunique!(out, seen, itr)

    function f(io)
        signal = Char[]
        foreach(_ -> push!(signal, read(io, Char)), 1:packet_length-1)
        pos = packet_length - 1
        while !eof(io)
            pos += 1
            push!(signal, read(io, Char))
            countunique(signal) == packet_length && break
            popfirst!(signal)
        end
        return pos
    end
    return f
end

ans₁ = open(read_signal(4), "input.txt")
ans₂ = open(read_signal(14), "input.txt")
