module IONPZ

using NPZ

"""
    write_read_npy(path, A)

Write array `A` to `.npy` and read it back.
"""
function write_read_npy(path::AbstractString, A)
    NPZ.npzwrite(path, A)
    return NPZ.npzread(path)
end

end # module

