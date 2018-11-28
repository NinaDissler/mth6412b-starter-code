import Base.show
import Base.isless,Base.==
import Base.copy

"""Type abstrait dont d'autres types de noeuds dériveront."""
abstract type AbstractNode{T} end

"""Type représentant les noeuds d'un graphe.

Exemple:

        noeud = Node("James", [π, exp(1)])
        noeud = Node("Kirk", "guitar")
        noeud = Node("Lars", 2)

"""
mutable struct Node{T} <: AbstractNode{T}
    name::String
    data::T
end

# on présume que tous les noeuds dérivant d'AbstractNode
# posséderont des champs `name` et `data`.

"""Renvoie le nom du noeud."""
name(node::AbstractNode) = string(node.name)

"""Renvoie les données contenues dans le noeud."""
data(node::AbstractNode) = node.data

"""Affiche un noeud"""
function show(node::AbstractNode)
    s = string("Node: ", name(node), ", Data: ", data(node))
    println(s)
end

""" Égalité entre deux noeuds"""
==(n::AbstractNode{T}, m::AbstractNode{T}) where T = strip(name(n))==strip(name(m))

""" Copie d'un noeud"""
function copy(node::AbstractNode)
	n=Node(name(node),copy(data(node)))
	n
end
