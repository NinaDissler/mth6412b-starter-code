
abstract type AbstractPriorityQueue{T}
    items=Vector{T}
end

""" Structure de file de priorité pour l'algotihme de Prim"""
mutable struct PrimPriorityQueue{K <: PrimNode{T}} <: AbstractPriorityQueue{T}
    items::Vector{K}
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
