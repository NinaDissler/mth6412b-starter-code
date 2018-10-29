import Base.popfirst!
import Base.push!

abstract type AbstractPriorityQueue{T} end

""" Structure de file de priorité pour l'algotihme de Prim"""
mutable struct PrimPriorityQueue{T} <: AbstractPriorityQueue{T}
    items::Vector{PrimNode{T}}
end


""" Retire et renvoie l'élément ayant la plus haute priorité """
function popfirst!(q::AbstractPriorityQueue)
    highest = q.items[1]
    for item in q.items[2:end]
        if priority(item) > priority(highest)
            highest = item
        end
    end
    idx = findall(x -> x == highest, q.items)[1]
    deleteat!(q.items, idx)
    highest
end

function push!(q::PrimPriorityQueue{T}, item::PrimNode{T}) where T
    push!(q.items,item)
end

is_empty(q::AbstractPriorityQueue) = length(q.items) == 0
