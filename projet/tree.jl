
include("node.jl")
import Base.show

""" Type abstrait dont d'autres types d'arbres deriveront"""
abstract type AbstractTree{T} end


"""Type representant un arbre récursivement"""
mutable struct Tree{T} <: AbstractTree{T}
    name::String
    root::AbstractNode{T}
    parent::Union{Tree{T},Nothing}
    sons::Union{Vector{Tree{T}},Nothing}
end

"""Renvoie le nom de l'arbre"""
name(tree::AbstractTree) = tree.name

"""Renvoie la racine de l'arbre"""
root(tree::AbstractTree) = tree.root

"""Renvoie les enfants de l'arbre"""
sons(tree::AbstractTree) = tree.sons

"""Renvoie le parent de l'arbre"""
get_parent(tree::AbstractTree) = tree.parent


""" Affichage d'un arbre"""
function show(tree::AbstractTree)
    println("Arbre : ", name(tree))
    println("Racine :")
    show(root(tree))
    str = get_parent(tree) == nothing ? "aucun" : name(get_parent(tree))
    println("Parent : ",str)
    str = sons(tree) == nothing ? "aucun" : name.(sons(tree))
    println("Enfants : ",str)
end

""" Un autre affichage plus complet"""
function show2(tree::AbstractTree)
    println("///Arbre : ", name(tree))
    str = get_parent(tree) == nothing ? "aucun" : name(get_parent(tree))
    println("Parent : ",str)
    println("Enfants :")
    if sons(tree) == nothing 
        println("aucun enfants")
    else
        for son in sons(tree)
            show2(son)
            println("************")
        end
    end
end

""" Fonction de modification du parent """
function set_parent!(tree_son::AbstractTree{T},tree_parent::AbstractTree{T}) where T
    tree_son.parent=tree_parent
end


""" Fonction d'ajout d'un enfant"""
function add_son!(parent::AbstractTree{T},son::AbstractTree{T}) where T
    if sons(parent) == nothing
        parent.sons = [son]
    else
        push!(parent.sons,son)
    end
end

""" Fonction de réinitialisation des enfants à l'ensemble vide"""
function delete_sons!(tree::AbstractTree)
    tree.sons=nothing
end
