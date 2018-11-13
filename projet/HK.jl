include("graph.jl")
include("kruskal.jl")
include("prim.jl")
include("tree.jl")

function HK(graph::AbstractGraph, root::AbstractNode, choix::Union{"prim","kruskal"}
    K=0
    N=nb_nodes(graph)
    pi_0=Vector{Int64}[]
    for i in (1,N)
      push!(pi_0,0)
    end
    Wopt=-Inf
end
