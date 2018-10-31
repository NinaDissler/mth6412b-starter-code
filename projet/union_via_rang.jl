""" Fonction d'union de deux arbres via le rang de leur racine"""
function unionvialerang!(treeA::AbstractTree,treeB::AbstractTree)
    rank(root(treeA))==rank(root(treeB)) && (setson!(treeA,treeB),setparent!(treeB,root(treeA)),rankincrement!(root(treeA)),return)
    if rank(root(treeA))>rank(root(treeB))
        setson!(treeA,treeB)
        setparent!(treeB,root(treeA))
    else
        setson!(treeB,treeA)
        setparent!(treeA,root(treeB))
    end
end
