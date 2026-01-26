module FunctionsDispatch

f(x) = x^2 + 1

g(x::Int) = x + 1
g(x::AbstractFloat) = x + 0.5

"""
    describe(x)

Tiny example of multiple dispatch for descriptions.
"""
describe(x::Int) = "Int: $(x)"
describe(x::AbstractFloat) = "Float: $(x)"
describe(x) = "Other: $(x)"

end # module

