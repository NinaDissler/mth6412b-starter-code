import Base.show

"""Type abstrait dont d'autres types d'arrêtes dériveront."""
abstract type AbstractEdge{T} end

"""Type représentant les arrêtes d'un graphe.

Exemple:

        edge = Edge(pare_noeud, existe?, poids)

"""

mutable struct Edge{T} <: AbstractEdge{T}
    nodeA::Node{T}
    nodeB::Node{T}
    weight::Int64
end

# on présume que toutes les arretes dérivant d'AbstractEdge
# posséderont des champs `noeud`, `data` et `voisins`.


"""Renvoie le poids d'une arrete"""
weight(edge::AbstractEdge) = edge.weight

"""Renvoie les noeuds d'une arrete"""
nodes(edge::AbstractEdge) = [edge.nodeA,edge.nodeB]

"""Affiche une arrête"""
function show(edge::AbstractEdge)
    s = string("Nodes ", name.(nodes(edge)), ", Weigth ", weight(edge))
    println(s)
end
