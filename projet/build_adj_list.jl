
function build_adj_list(graph::AbstractGraph{T})
    adj_list=Dict{Tuple(Node{T},Node{T}),Int64}()
    for edge in edges(graph)
        adj_list[(nodeA(edge),nodeB(edge))]=weight(edge)
    end
end
