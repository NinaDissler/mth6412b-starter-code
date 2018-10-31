include("node.jl")
import Base.push!

function neighbours(ref_node::AbstractNode{T},graph::AbstractGraph{T}) where T
   list=Vector{AbstractNode{T}}([])
   for item in nodes(graph)
        for edge in edges(graph)
            if nodes(edge)[1] == ref_node && nodes(edge)[2]==item
                push!(list,item)
            elseif nodes(edge)[2] == ref_node && nodes(edge)[1]==item
                push!(list,item)
            end
        end
    end
    list
end
