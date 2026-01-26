using Test

include(joinpath(@__DIR__, "..", "src", "FunctionsDispatch.jl"))
using .FunctionsDispatch

@testset "FunctionsDispatch" begin
    @test FunctionsDispatch.f(2) == 5
    @test FunctionsDispatch.g(1) == 2
    @test FunctionsDispatch.g(1.0) == 1.5
    @test occursin("Int", FunctionsDispatch.describe(1))
end

