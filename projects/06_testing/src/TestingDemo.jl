module TestingDemo

"""
    safe_div(x, y)

Divide with an explicit error on `y == 0` (for testing/demo).
"""
function safe_div(x, y)
    y == 0 && throw(DomainError(y, "division by zero"))
    return x / y
end

end # module

