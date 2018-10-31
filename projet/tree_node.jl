
include("node.jl")

""" Définition préalable d'un noeud dans un arbre avec une donnée et un rang"""
mutable struct TreeNode{T} <: AbstractNode{T}
    name::String
    data::T
    rank::Int64
end

"""Renvoie le nom du noeud."""
rank(node::AbstractNode) = node.rank

""" Fonction d'incrément du rang"""
function rank_increment!(node::TreeNode)
    node.rank+=1
end
