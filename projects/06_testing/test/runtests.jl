using Test

include(joinpath(@__DIR__, "..", "src", "TestingDemo.jl"))
using .TestingDemo

@testset "TestingDemo" begin
    @test TestingDemo.safe_div(1, 2) == 0.5
    @test_throws DomainError TestingDemo.safe_div(1, 0)
end

