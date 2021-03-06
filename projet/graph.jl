import Base.show
import Base.copy

include("node.jl")
include("edge.jl")

"""Type abstrait dont d'autres types de graphes dériveront."""
abstract type AbstractGraph{T} end

"""Type representant un graphe comme un ensemble de noeuds.

Exemple :

		node1 = Node("Joe", 3.14)
		node2 = Node("Steve", exp(1))
		node3 = Node("Jill", 4.12)
		G = Graph("Ick", [node1, node2, node3])

Attention, tous les noeuds doivent avoir des données de même type.
"""
mutable struct Graph{T} <: AbstractGraph{T}
	name::String
	nodes::Vector{Node{T}}
	edges::Vector{Edge{T}}
end

"""Ajoute un noeud au graphe."""
function add_node!(graph::AbstractGraph{T}, node::AbstractNode{T}) where T
	push!(graph.nodes, node)
	graph
end

"""Supprime un noeud du graphe."""
function delete_node!(graph::AbstractGraph{T}, node::AbstractNode{T}) where T
    index=findall(x->x==node,graph.nodes)[1]
    deleteat!(graph.nodes, index)
    graph
end

"""Ajoute une arrête au graphe."""
function add_edge!(graph::AbstractGraph{T}, edge::AbstractEdge{T}) where T
	push!(graph.edges, edge)
	graph
end

function delete_edge!(graph::AbstractGraph{T}, edge::AbstractEdge{T}) where T
    index=findall(x->x==edge,graph.edges)[1]
    deleteat!(graph.edges, index)
    graph
end

# on présume que tous les graphes dérivant d'AbstractGraph
# posséderont des champs `name` et `nodes`.

"""Renvoie le nom du graphe."""
name(graph::AbstractGraph) = graph.name

"""Renvoie la liste des noeuds du graphe."""
nodes(graph::AbstractGraph) = graph.nodes

"""Renvoie le nombre de noeuds du graphe."""
nb_nodes(graph::AbstractGraph) = length(graph.nodes)


"""Renvoie la liste des arrêtes du graphe."""
edges(graph::AbstractGraph) = graph.edges

"""Renvoie le nombre de arrêtes du graphe."""
nb_edges(graph::AbstractGraph) = length(graph.edges)

"""Affiche un graphe"""
function show(graph::Graph)
	graph_name = name(graph)
	graph_nb_nodes = nb_nodes(graph)
	graph_nb_edges = nb_edges(graph)
	println("Graph ", graph_name, " has ", graph_nb_nodes, " nodes")
	for node in nodes(graph)
		show(node)
	end
	println("and ", graph_nb_edges, " edges")
	for edge in edges(graph)
		show(edge)
	end
end

""" Copie d'un graphe """
function copy(graph::AbstractGraph)
	g=Graph("copie", (nodes(graph)),(edges(graph)))
	g
end
