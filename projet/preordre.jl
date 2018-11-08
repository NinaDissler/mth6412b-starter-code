import Base.push!

include("tree.jl")

function preodre(tree::AbstractTree{T},solution::Array{AbstractNode{T}}) where T
  tree==nothing && return
  push!(solution,root(tree))
  for son in sons(tree)
    preordre(son,solution)
  end
end
