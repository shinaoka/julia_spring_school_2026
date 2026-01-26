using Test

include(joinpath(@__DIR__, "..", "src", "LinalgBench.jl"))
using .LinalgBench

@testset "LinalgBench" begin
    res = LinalgBench.gemm_gflops(16; reps=1)
    @test res.gflops > 0
    @test res.seconds > 0
end

