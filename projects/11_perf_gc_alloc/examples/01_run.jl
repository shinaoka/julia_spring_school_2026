using Pkg
Pkg.activate(@__DIR__ |> dirname)
Pkg.instantiate()

include(joinpath(@__DIR__, "..", "src", "PerfGCAlloc.jl"))
using .PerfGCAlloc

res = PerfGCAlloc.compare(10^6)
@show res

