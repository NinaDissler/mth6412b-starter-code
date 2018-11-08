include("tree.jl")

""" Fonction de parcours préordre d'un arbre quelconque"""
function preordre(tree::AbstractTree)
    tree==nothing && return
    sol=[]
    push!(sol,root(tree))
    if sons(tree)==nothing
        return root(tree)
    else
        for son in sons(tree)
            sol=hcat(sol,preordre(son))
        end
    end
    sol
end
