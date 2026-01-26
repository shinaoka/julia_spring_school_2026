using Pkg
Pkg.activate(@__DIR__ |> dirname)
Pkg.instantiate()

include(joinpath(@__DIR__, "..", "src", "BroadcastBench.jl"))
using .BroadcastBench

res = BroadcastBench.sin_throughput(10^7)
@show res

