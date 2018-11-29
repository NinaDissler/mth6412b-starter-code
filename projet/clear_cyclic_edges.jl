function clear_cyclic_edges!(g::AbstractGraph)
    indexes=Vector{Int64}()
    for i = 1:length(edges(g))
        if nodes(edges(g)[i])[1]==nodes(edges(g)[i])[2]
            push!(indexes,i)
        end
    end
    deleteat!(edges(g),indexes)
    g
end
