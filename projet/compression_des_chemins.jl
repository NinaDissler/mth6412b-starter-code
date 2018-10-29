
function compression_des_chemins(tree_global::AbstractTree{T},tree_start::AbstractTree{T})
    tree=tree_start
    trees=Vector{Tree{T}}([])
    while parent(tree)=!nothing
        tree=parent(tree)
        push!(trees,tree)
    end
    root=tree
    for item in trees
        set_parent!(item,root)
        add_son!(root,item)
    end
end
