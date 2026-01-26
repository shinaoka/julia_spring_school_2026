using Test

include(joinpath(@__DIR__, "..", "src", "ProjectBasics.jl"))
using .ProjectBasics

@testset "ProjectBasics" begin
    @test ProjectBasics.hello() == "hello from ProjectBasics"
end

