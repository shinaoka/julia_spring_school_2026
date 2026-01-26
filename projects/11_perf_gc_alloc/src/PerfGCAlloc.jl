module PerfGCAlloc

using BenchmarkTools

"""
    slow_sum(xs)

Intentionally allocates by creating a temporary array.
"""
slow_sum(xs::AbstractVector{<:Real}) = sum(xs .+ 1)

"""
    fast_sum(xs)

Avoids allocation by looping explicitly.
"""
function fast_sum(xs::AbstractVector{<:Real})
    s = 0.0
    @inbounds for x in xs
        s += x + 1
    end
    return s
end

"""
    compare(n)

Return timing/allocation comparison between slow_sum and fast_sum.
"""
function compare(n::Integer)
    xs = rand(n)
    t_slow = @belapsed slow_sum($xs)
    t_fast = @belapsed fast_sum($xs)
    a_slow = @allocated slow_sum(xs)
    a_fast = @allocated fast_sum(xs)
    return (t_slow=t_slow, t_fast=t_fast, a_slow=a_slow, a_fast=a_fast)
end

end # module

