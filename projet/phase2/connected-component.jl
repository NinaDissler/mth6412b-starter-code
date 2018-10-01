import Base.show

""" Type abstrait dont d'autres types de composantes connexes deriveront"""
abstract type AbstractConnectedComponent{T} end

"""Type representant une composante connexe"""
mutable struct ConnectedComponent{T} <: AbstractConnectedComponent{T}
		#name::String
        #graph::Graph{T}
        nodes::Vector{Node{T}}
        edges::Vector{Edge{T}}
end

ConnectedComponent() = ConnectedComponent(Node{Any}[],Edge{Any}[])

#"""Renvoie le nom de la composante connexe."""
#name(component::AbstractConnectedComponent) = component.name

#""" Renvoie le graphe contenant la composante connexe"""
#graph(component::AbstractConnectedComponent) = component.graph

""" Renvoie les noeuds de la composante connexe"""
nodes(component::AbstractConnectedComponent) = component.nodes

"""Renvoie le nombre de noeuds de la composante connexe"""
nb_nodes(component::AbstractConnectedComponent) = length(component.nodes)

""" Renvoie les arêtes de la composante connexe"""
edges(component::AbstractConnectedComponent) = component.edges

"""Renvoie le nombre d'arêtes de la composante connexe"""
nb_edges(component::AbstractConnectedComponent) = length(component.edges)

"""Ajoute un noeud à la CC."""
function add_node!(cc::ConnectedComponent{T}, node::Node{T}) where T
	push!(cc.nodes, node)
	cc
end

"""Ajoute une arrête à la CC."""
function add_edge!(cc::ConnectedComponent{T}, edge::Edge{T}) where T
	push!(cc.edges, edge)
	cc
end

"""Affiche une composante connexe"""
function show(component::ConnectedComponent)
	#component_name = name(component)
	#component_graph = graph(component)
	component_nb_nodes = nb_nodes(component)
	component_nb_edges = nb_edges(component)
	#println("Connected component ", component_name, " in ", name(component_graph)," has ", component_nb_nodes, " nodes")
	println("Connected component has ", component_nb_nodes, " nodes")
	for node in nodes(component)
		show(node)
	end
	println("and ", component_nb_edges, " edges")
	for edge in edges(component)
		show(edge)
	end
end
