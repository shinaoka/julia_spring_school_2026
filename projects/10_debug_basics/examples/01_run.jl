using Pkg
Pkg.activate(@__DIR__ |> dirname)
Pkg.instantiate()

include(joinpath(@__DIR__, "..", "src", "DebugBasics.jl"))
using .DebugBasics

x = rand(5)
@show x
@show DebugBasics.mean_checked(x)

