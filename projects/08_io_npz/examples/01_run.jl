using Pkg
Pkg.activate(@__DIR__ |> dirname)
Pkg.instantiate()

include(joinpath(@__DIR__, "..", "src", "IONPZ.jl"))
using .IONPZ

A = rand(3, 4)
B = IONPZ.write_read_npy(joinpath(@__DIR__, "A.npy"), A)
@show size(A) size(B)

