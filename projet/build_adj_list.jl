include("node.jl")
include("edge.jl")
include("graph.jl")

function build_adj_list(graph::AbstractGraph)
    adj_list = Dict{AbstractNode, Dict{AbstractNode,Int64}}()
    for node in nodes(graph)
        adj_list[node]=Dict{AbstractNode,Int64}()
    end
    for edge in edges(graph)
        adj_list[nodeA(edge)][nodeB(edge)]=weight(edge)
    end
    adj_list
end
