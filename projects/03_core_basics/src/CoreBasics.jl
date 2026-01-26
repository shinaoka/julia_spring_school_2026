module CoreBasics

"""
    harmonic(n)

Compute harmonic sum ∑_{k=1}^n 1/k as Float64.
"""
function harmonic(n::Integer)
    n <= 0 && throw(ArgumentError("n must be positive"))
    s = 0.0
    for k in 1:n
        s += 1 / k
    end
    return s
end

"""
    column_copy_and_view(A)

Return `(copy_col, view_col)` for `A[:, 1]` and `@view A[:, 1]`.
"""
function column_copy_and_view(A::AbstractMatrix)
    copy_col = A[:, 1]
    view_col = @view A[:, 1]
    return (copy_col=copy_col, view_col=view_col)
end

end # module

