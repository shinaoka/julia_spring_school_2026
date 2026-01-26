using Pkg
Pkg.activate(@__DIR__ |> dirname)
Pkg.instantiate()

include(joinpath(@__DIR__, "..", "src", "CoreBasics.jl"))
using .CoreBasics

@show CoreBasics.harmonic(10)

A = rand(5, 5)
cols = CoreBasics.column_copy_and_view(A)
@show typeof(cols.copy_col) typeof(cols.view_col)

