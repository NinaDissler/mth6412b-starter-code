include("node.jl")
import Base.push!

function neighbours(pnode::AbstractNode{T},graph::AbstractGraph{T}) where T
   list=Vector{AbstractNode}([])
   for item in nodes(graph)
        for edge in edges(graph)
            if nodes(edge)[1] == pnode && nodes(edge)[2]==item
                push!(list,item)
            elseif nodes(edge)[2] == pnode && nodes(edge)[1]==item
                push!(list,item)
            end
            end
    end
    list
end
