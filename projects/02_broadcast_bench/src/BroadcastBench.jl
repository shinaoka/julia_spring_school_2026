module BroadcastBench

using BenchmarkTools

"""
    sin_throughput(n)

Measure throughput (elements/sec) for `sin.(x)` with `x = rand(n)`.
Returns a named tuple with seconds and throughput.
"""
function sin_throughput(n::Integer)
    n <= 0 && throw(ArgumentError("n must be positive"))
    x = rand(n)
    # Measure steady-state time; ignore compilation.
    t = @belapsed sin.($x)
    return (seconds=t, n=n, elems_per_sec=n / t)
end

end # module

