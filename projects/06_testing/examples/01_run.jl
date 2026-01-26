using Pkg
Pkg.activate(@__DIR__ |> dirname)
Pkg.instantiate()

using Pkg
Pkg.test()

