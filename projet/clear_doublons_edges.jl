function clear_doublons_edges!(g::AbstractGraph)
    removed=0
    for i = 1: nb_edges(g)
        edge=edges(g)[i-removed]
        if length(findall(x -> x == edge, edges(g)))==2
            deleteat!(g.edges,i-removed)
            removed=removed+1
        end
    end
    g
end
