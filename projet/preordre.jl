include("tree.jl")
include("tournee.jl")

""" Fonction de parcours préordre d'un arbre quelconque"""
function preordre(tree::AbstractTree{T}) where T
    tree==nothing && return
    sol=Array{Node{T}}([])
    push!(sol,root(tree))
    if sons(tree)==nothing
        return root(tree)
    else
        for son in sons(tree)
            sol=vcat(sol,preordre(son))
        end
    end
    sol
end
