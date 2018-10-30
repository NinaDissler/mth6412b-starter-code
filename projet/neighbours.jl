
import Base.push!

function neighbours(pnode::AbstractNode{T},graph::AbstractGraph{T}) where T
   list=Vector{AsbtractNode}([])
   for item in nodes(graph)
        for edge in edges(graph)
            if nodeA(edge)==pnode && nodeB(edge)==item
                push!(list,item)
            elseif nodeB(edge)==pnode && nodeA(edge)==item
                push!(list,item)
            end
            end
    end
    list
end
