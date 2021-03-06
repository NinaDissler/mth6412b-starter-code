include("distance.jl")
include("graph.jl")

function eval_weights(v::Vector{Node{T}}, g::Graph{T}) where T
    sum = 0
    for i=1 : (length(v)-1)
        sum += distance(v[i],v[i+1],g)
    end
    sum += distance(v[1], v[end], g)
end
