# include("tree.jl")
# include("tree_node.jl")
# function compression_des_chemins!(tree_global::AbstractTree{T},tree_start::AbstractTree{T}) where T
#     tree=tree_start
#     trees=Vector{Tree{T}}([])
#     while get_parent(tree) != nothing
#         tree=get_parent(tree)
#         push!(trees,tree)
#     end
#     root=tree
#     for item in trees
#         delete_sons!(item)
#         set_parent!(item,root)
#         add_son!(root,item)
#     end
# end

function compression_des_chemins!(tree::AbstractTree{})
    flag = true
    sons(tree)==nothing && return tree
    for son in sons(tree)
        if sons(son) != nothing
            flag=false
        end
    end
    flag==true && return tree
    for son in sons(tree)
        compression_des_chemins!(son)
        for son_of_son in sons(son)
            set_parent!(son_of_son,tree)
            add_son!(tree,son_of_son)
        end
        delete_sons!(son)
    end
end
