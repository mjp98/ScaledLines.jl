using ScaledLines
using Documenter

DocMeta.setdocmeta!(ScaledLines, :DocTestSetup, :(using ScaledLines); recursive=true)

makedocs(;
    modules=[ScaledLines],
    authors="Matthew Priddin and contributors",
    repo="https://github.com/mjp98/ScaledLines.jl/blob/{commit}{path}#{line}",
    sitename="ScaledLines.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://mjp98.github.io/ScaledLines.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/mjp98/ScaledLines.jl",
    devbranch="main",
)
