using Pkg
Pkg.activate(@__DIR__ |> dirname)
Pkg.instantiate()

include(joinpath(@__DIR__, "..", "src", "FunctionsDispatch.jl"))
using .FunctionsDispatch

@show FunctionsDispatch.f(3)
@show FunctionsDispatch.g(1) FunctionsDispatch.g(1.0)
@show FunctionsDispatch.describe(1) FunctionsDispatch.describe(2.0) FunctionsDispatch.describe("hi")

