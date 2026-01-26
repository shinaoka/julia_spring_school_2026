using Pkg
Pkg.activate(@__DIR__ |> dirname)
Pkg.instantiate()

include(joinpath(@__DIR__, "..", "src", "PlotPlotsGR.jl"))
using .PlotPlotsGR
using Plots

p = PlotPlotsGR.demo_plot()
savefig(p, joinpath(@__DIR__, "sin.png"))
@info "saved plot" path=joinpath(@__DIR__, "sin.png")

