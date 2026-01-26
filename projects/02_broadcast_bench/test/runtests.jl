using Test

include(joinpath(@__DIR__, "..", "src", "BroadcastBench.jl"))
using .BroadcastBench

@testset "BroadcastBench" begin
    res = BroadcastBench.sin_throughput(10^4)
    @test res.seconds > 0
    @test res.elems_per_sec > 0
end

