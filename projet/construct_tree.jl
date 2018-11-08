include("tree.jl")
include("graph.jl")
include("connected-component.jl")

function construct_tree(name::String, graph::AbstractGraph{T}, root::AbstractNode{T}) where T
  tree=Tree(name,root,nothing,nothing)
  copiedgraph=copy(graph)
  length(neighbours(root))==0 && return tree
  for son in neighbours(root,copiedgraph)
    delete_node!(root,copiedgraph)
    tson=construct_tree(name,graph,son)
    add_son!(tree,tson)
    set_parent!(tson,tree)
  end
end
