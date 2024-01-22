using Pkg; Pkg.activate(@__DIR__)
using Literate

preprocess(path, str) = replace(str, "__DIR = @__DIR__" => "__DIR = \"$(dirname(path))\"")

get_example_path(p) = joinpath(@__DIR__, "..", "examples", p)
OUTPUT = joinpath(@__DIR__, "src", "tutorials")


TUTORIALS = [
        "ClosureImaging/main.jl",
        "GeometricModeling/main.jl",
        "HybridImaging/main.jl",
        "LoadingData/main.jl",
        "PolarizedImaging/main.jl",
        "StokesIImaging/main.jl"
        ]

withenv("JULIA_PROJECT"=>"Literate") do
    for (d, paths) in (("", TUTORIALS),),
        (i,p) in enumerate(paths)
        println(p)
        name = "$(first(rsplit(p, "/")))"
        p_ = get_example_path(p)
        jl_expr = "using Literate; preprocess(path, str) = replace(str, \"__DIR = @__DIR__\" => \"__DIR = \\\"\$(dirname(path))\\\"\"); Literate.markdown(\"$(p_)\", \"$(joinpath(OUTPUT, d))\"; execute=true, name=\"$name\", documenter=true, preprocess=Base.Fix1(preprocess, \"$(p_)\"))"
        cm = `julia --project=$(@__DIR__) -e $(jl_expr)`
        run(cm)

    end
end
