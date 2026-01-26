using Pkg
Pkg.activate(@__DIR__ |> dirname)
Pkg.instantiate()

using Revise
includet(joinpath(@__DIR__, "..", "src", "ReviseDemo.jl"))
using .ReviseDemo

@show ReviseDemo.square(4)

