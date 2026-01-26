using Pkg
Pkg.activate(@__DIR__ |> dirname)
Pkg.instantiate()

using Pkg
@show Pkg.project().path
Pkg.status()

include(joinpath(@__DIR__, "..", "src", "ProjectBasics.jl"))
using .ProjectBasics
@show ProjectBasics.hello()

