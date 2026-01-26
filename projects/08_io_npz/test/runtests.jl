using Test

include(joinpath(@__DIR__, "..", "src", "IONPZ.jl"))
using .IONPZ

@testset "IONPZ" begin
    A = rand(2, 3)
    path = joinpath(@__DIR__, "tmp.npy")
    B = IONPZ.write_read_npy(path, A)
    @test size(B) == size(A)
end

