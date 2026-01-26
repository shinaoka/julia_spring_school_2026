using Test

include(joinpath(@__DIR__, "..", "src", "PerfGCAlloc.jl"))
using .PerfGCAlloc

@testset "PerfGCAlloc" begin
    xs = rand(100)
    @test PerfGCAlloc.slow_sum(xs) ≈ PerfGCAlloc.fast_sum(xs)
    res = PerfGCAlloc.compare(10^4)
    @test res.a_slow >= res.a_fast
end

