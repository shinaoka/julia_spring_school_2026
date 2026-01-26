using Pkg
Pkg.activate(@__DIR__ |> dirname)
Pkg.instantiate()

include(joinpath(@__DIR__, "..", "src", "LinalgBench.jl"))
using .LinalgBench

res = LinalgBench.gemm_gflops(512; reps=3)
@show res

