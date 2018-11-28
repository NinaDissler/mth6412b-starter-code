import Base.push!
include("neighbours.jl")

function degrees(graph::AbstractGraph)
    degrees=Vector{Int64}()
    for node in nodes(graph)
        degree=length(neighbours(node,graph))
        push!(degrees,degree)
    end
    degrees
end
