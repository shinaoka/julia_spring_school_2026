module PlotPlotsGR

using Plots

"""
    demo_plot()

Return a simple plot object.
"""
function demo_plot()
    x = range(0, 2π; length=400)
    y = sin.(x)
    return plot(x, y; label="sin(x)", xlabel="x", ylabel="y", title="sin")
end

end # module

