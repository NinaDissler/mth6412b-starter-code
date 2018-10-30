import Base.popfirst!
import Base.push!
using Test
import Base.length

#Algorithme de Prim
# include("prim_node.jl")
include("prim_priority_queue.jl")
include("graph.jl")
include("neighbours.jl")
include("build_adj_list.jl")
include("distance.jl")

function prim(graph::AbstractGraph{T},s::AbstractNode{T}) where T
    # Test d'appartenance du sommet de départ au graphe
    @test (s in nodes(graph))
    # Initialisation d'une liste des résultats
    solution=Vector{PrimNode{T}}([])
    # adj_list = build_adj_list(graph)
    # Initialisation d'une file de priorité vide qui sera modifiée à chaque itération
    q=PrimPriorityQueue{T}([])
    # Remplissage intial de la file avec des noeuds de Prim dont le min weight est Inf et les parents nothing
    # sauf pour le sommet de départ ou min weight = 0.
    for node in nodes(graph)
        # item = node
        # item = node == s ? PrimNode(name(node),data(node),0,nothing):PrimNode(name(node),data(node),Inf,nothing)
        if (name(node) == name(s) && data(node) == data(s) )
            item = PrimNode(name(node),data(node),0,nothing)
        else
            item = PrimNode(name(node),data(node),Inf,nothing)
        end
        push!(q,item)
    end

    # Test de vérification du transfert de tous les noeuds dans la file
    @test (length(q)==nb_nodes(graph))

    # Tant que tous les noeuds n'ont pas été ajouté à l'arbre : ajouter celui de plus court min_weight et modifier
    # les attributs min_weight et parent de ses voisins pas encore ajoutés à l'arbre
    while is_not_empty(q)
        # On repère le noeud le plus proche de l'arbre et on l'ajoute à une liste de noeuds de Prim
        ref=popfirst!(q)
        push!(solution,ref)
        p = PrimPriorityQueue{T}([])
        # On reconstruit la file de priorité avec les attributs modifiés
        while is_not_empty(q)
            item=popfirst!(q)
            if item in neighbours(ref,graph) && distance(item,ref,graph) < min_weight(item)
                set_min_weight!(item,distance(item,ref,graph))
                set_parent!(item,ref)
                push!(p,item)
            else
                push!(p,item)
            end
        end
        q=p
    end

    # @test is_empty(q)
    # @test length(solution)== nb_nodes(graph)
    solution

    # Retourne : liste des noeuds avec leur parents et poids de l'arête selectionnée dans l'arbre de recouvrement
    # Construction du graphe de recouvrement
    graphe_recouvrement=Graph("Graphe recouvrement",nodes(graph),Vector{Edge{T}}([]))
    for node in solution[2:end]
        nodeA=Node(name(node),data(node))
        nodeB=Node(name(get_parent(node)),data(get_parent(node)))
        add_edge!(graphe_recouvrement,Edge(nodeA,nodeB,distance(nodeA,nodeB,graph)))
    end

    @test nb_nodes(graphe_recouvrement)==nb_nodes(graph)
    @test nb_edges(graphe_recouvrement)==nb_nodes(graph)-1

    graphe_recouvrement
end
