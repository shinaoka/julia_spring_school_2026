using Test

include(joinpath(@__DIR__, "..", "src", "DebugBasics.jl"))
using .DebugBasics

@testset "DebugBasics" begin
    @test DebugBasics.mean_checked([1.0, 2.0]) == 1.5
    @test_throws AssertionError DebugBasics.mean_checked(Float64[])
end

