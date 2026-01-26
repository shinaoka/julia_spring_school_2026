module DebugBasics

"""
    mean_checked(x)

Mean with a precondition check (for demo).
"""
function mean_checked(x::AbstractVector)
    @assert !isempty(x) "x must be non-empty"
    s = 0.0
    for v in x
        s += v
    end
    return s / length(x)
end

end # module

