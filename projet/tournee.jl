mutable struct Turn{T}
    items::Vector{Node{T}}
end

function show(tournee::Turn)
    str="Tournée :"
    for node in tournee.items
        str=string(str, name(node)," ")
    end
    println(str)
end

function push!(turn::Turn{T},item::AbstractNode{T}) where T
    push!(turn.items,item)
    turn
end
