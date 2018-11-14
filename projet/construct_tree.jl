# include("tree.jl")
include("graph.jl")
include("connected-component.jl")

function construct_tree(graph::AbstractGraph{T}, root::AbstractNode{T}) where T
    tree=Tree(name(root),root,nothing,nothing)
    copied_graph=copy(graph)
    if length(neighbours(root,copied_graph))==0
        return tree
    else
        delete_node!(copied_graph,root)
        for son in neighbours(root,copied_graph)
            tson=construct_tree(copied_graph,son)
            add_son!(tree,tson)
            set_parent!(tson,tree)
        end
    end
    tree
end
