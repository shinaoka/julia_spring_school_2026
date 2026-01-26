module LinalgBench

using LinearAlgebra

"""
    gemm_gflops(n; reps=1)

Estimate GFLOPs for `A*B` where `A,B` are `n×n` random matrices.

This is a **teaching utility** for getting FLOPs/GFLOPs intuition.
"""
function gemm_gflops(n::Integer; reps::Integer=1)
    n <= 0 && throw(ArgumentError("n must be positive"))
    reps <= 0 && throw(ArgumentError("reps must be positive"))

    A = rand(n, n)
    B = rand(n, n)

    # Warmup
    C = A * B

    t = @elapsed begin
        for _ in 1:reps
            C = A * B
        end
    end

    flops = 2 * n^3 * reps
    gflops = flops / t / 1e9
    return (gflops=gflops, seconds=t, n=n, reps=reps, checksum=sum(C))
end

end # module

