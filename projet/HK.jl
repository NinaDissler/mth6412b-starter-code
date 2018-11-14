include("graph.jl")
include("kruskal.jl")
include("prim.jl")
include("tree.jl")

function HK(graph::AbstractGraph, root::AbstractNode, choix::Union{"prim","kruskal"}
    K=0
    N=nb_nodes(graph)
    pi_0=Vector{Int64}[]
    for i in (1,N)
      push!(pi_0,0)
    end
    Wopt=-Inf
    while true
        println("Itération",K)
        #######################################################################
        println("Construction du 1-tree")
        # Copie du graphe
        g=copy(graph)
        # Supression d'un noeud qui n'est pas la racine du MST
        if root==nodes(g)[1]
            deletednode=nodes(g)[end])
        else
            deletednode=nodes(g)[1])
        end
        delete_node!(g,deletednode)
        # Construction du MST
        MST = choix=="prim"? prim(g,nodes(g)[1]):kruskal(g)
        # Ajout du noeud supprimé au début
        one_tree=add_node!(MST,deletednode)
        # On le relie par deux arêtes de poids min
        # Selection des arêtes
        select_edges=copy(edges(g))
        edgetoadd1=select_edges[argmax(weight.(select_edges))]
        deleteat!(select_edges,argmax(weight.(select_edges)))
        edgetoadd2=select_edges[argmax(weight.(select_edges))]
        # Ajout au MST (toujours de type graph)
        add_edge!(one_tree,edgetoadd1)
        add_edge!(one_tree,edgetoadd2)
        ######################################################################
        # Calcul de z(pik)
        z=size(one_tree)-2*sum(pi_0)
        Wopt=max(Wopt,z)          

end
