using Test

include(joinpath(@__DIR__, "..", "src", "PlotPlotsGR.jl"))
using .PlotPlotsGR

@testset "PlotPlotsGR" begin
    p = PlotPlotsGR.demo_plot()
    @test p !== nothing
end

