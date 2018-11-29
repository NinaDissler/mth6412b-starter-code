import Base.show

"""Type representant une composante connexe : herite des méthodes de AbstractGraph"""
mutable struct ConnectedComponent{T} <: AbstractGraph{T}
		name::String
        nodes::Vector{Node{T}}
        edges::Vector{Edge{T}}
end

"""Affiche une composante connexe"""
function show(component::ConnectedComponent)
	component_nb_nodes = nb_nodes(component)
	component_nb_edges = nb_edges(component)
	println("Connected component has ", component_nb_nodes, " nodes")
	for node in nodes(component)
		show(node)
	end
	println("and ", component_nb_edges, " edges")
	for edge in edges(component)
		show(edge)
	end
end
