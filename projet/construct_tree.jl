include("tree.jl")
include("graph.jl")
include("connected-component.jl")

function construct_tree(graph::AbstractGraph{T}, root::AbstractNode{T}) where T
    tree=Tree(name(root),root,nothing,nothing)
    if length(neighbours(root,graph))==0
        return tree
    else
        delete_node!(graph,root)
        for son in neighbours(root,graph)
            tson=construct_tree(graph,son)
            add_son!(tree,tson)
            set_parent!(tson,tree)
        end
    end
    tree
end
