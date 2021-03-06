import Base.show
import Base.==, Base.isless

"""Type abstrait dont d'autres types d'arrêtes dériveront."""
abstract type AbstractEdge{T} end

"""Type représentant les arrêtes d'un graphe.

Exemple:

        edge = Edge("James", "Kirk", 5)

"""

mutable struct Edge{T} <: AbstractEdge{T}
    nodeA::Node{T}
    nodeB::Node{T}
    weight::Float64
end

# on présume que toutes les arrêtes dérivant d'AbstractEdge
# posséderont des champs `nodeA`, `nodeB` et `weight`.

"""Renvoie les noeuds d'une arrête"""
nodes(edge::AbstractEdge) = [edge.nodeA,edge.nodeB]

"""Renvoie le poid d'une arrête"""
weight(edge::AbstractEdge) = edge.weight

""" Change le poids d'une arête"""
function set_weight!(edge::AbstractEdge,value::Float64)
    edge.weight=value
end

"""Affiche une arrête"""
function show(edge::AbstractEdge)
    s = string("Nodes: ", name.(nodes(edge)), "; Weight: ", weight(edge))
    println(s)
end

""" Égalité entre deux arêtes"""
==(n::AbstractEdge{T}, m::AbstractEdge{T}) where T = (nodes(n)==nodes(m) || reverse(nodes(n))==nodes(m))

""" Copie d'une arête """
function copy(edge::AbstractEdge)
    save=Edge(copy(nodes(edge)[1]),copy(nodes(edge)[2]),copy(weight(edge)))
    save
end
