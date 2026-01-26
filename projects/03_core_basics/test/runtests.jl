using Test

include(joinpath(@__DIR__, "..", "src", "CoreBasics.jl"))
using .CoreBasics

@testset "CoreBasics" begin
    @test CoreBasics.harmonic(1) == 1.0
    @test CoreBasics.harmonic(2) ≈ 1.5
    cols = CoreBasics.column_copy_and_view(rand(3, 3))
    @test length(cols.copy_col) == 3
end

