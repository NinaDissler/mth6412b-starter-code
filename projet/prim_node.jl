include("node.jl")

import Base.isless,Base.==

mutable struct PrimNode{T} <: AbstractNode{T}
    name::String
    data::T
    min_weight::Union{Int64,typeof(Inf)}
    parent::Union{PrimNode{T},Nothing}
end

# Name et data déjà codés dans la phase 1

""" Renvoie le poids minimal pour relier à l'arbre de recouvrement"""
min_weight(node::AbstractNode)=node.min_weight

""" Renvoie sa priorité dans la file de priorité de l'algorithme de Prim"""
priority(node::AbstractNode)=node.min_weight

""" Renvoie le parent du noeud """
get_parent(node::AbstractNode)=node.parent

==(n::AbstractNode, m::AbstractNode) = (name(n)==name(m) && data(n)==data(m))
