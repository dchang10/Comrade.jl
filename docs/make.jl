using Documenter
using Comrade
using ComradeBase

using Literate

using ComradeAHMC
using ComradeOptimization
using ComradeNested
using ComradeDynesty
using ComradeAdaptMCMC
using OptimizationBBO
using Glob
using Plots


# Make the examples using Literate
GENERATED = joinpath(@__DIR__, "../", "examples")
OUTDIR = joinpath(@__DIR__, "src", "examples")

SOURCE_FILES = Glob.glob("*.jl", GENERATED)
foreach(fn -> Literate.markdown(fn, OUTDIR, documenter=true), SOURCE_FILES)

MD_FILES = joinpath.("examples", replace.(basename.(SOURCE_FILES), ".jl"=>".md"))


makedocs(;
    modules=[ComradeBase, Comrade,
             ComradeOptimization, ComradeAHMC,
             ComradeNested, ComradeDynesty,
             ComradeAdaptMCMC],
    repo="https://github.com/ptiede/Comrade.jl/blob/{commit}{path}#{line}",
    sitename="Comrade.jl",
    pages=Any[
        "Home" => "index.md",
        "benchmarks.md",
        "vlbi_imaging_problem.md",
        "conventions.md",
        "Tutorials" => MD_FILES,
        "Libraries" => [
                        "libs/optimization.md",
                        "libs/ahmc.md",
                        "libs/nested.md",
                        "libs/dynesty.md",
                        "libs/adaptmcmc.md"
                       ],
        "interface.md",
        "base_api.md",
        "api.md"
    ],
    format = Documenter.HTML(), draft=true
)

deploydocs(;
    repo="github.com/ptiede/Comrade.jl",
    push_preview=true,
    devbranch = "main",
)
