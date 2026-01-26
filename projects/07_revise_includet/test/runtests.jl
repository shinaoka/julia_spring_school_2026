using Test

include(joinpath(@__DIR__, "..", "src", "ReviseDemo.jl"))
using .ReviseDemo

@testset "ReviseDemo" begin
    @test ReviseDemo.square(3) == 9
end

