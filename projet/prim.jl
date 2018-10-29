
#Algorithme de Prim
include("prim_node.jl")
include("prim_priority_queue.jl")
include("projet/phase1/graph.jl")

function prim(graph::AbstractGraph{T},s::AbstractNode{T})
    # Initialisation d'une liste des résultats
    solution=Vector{PrimNode{T}}([])
    # Initialisation d'une file de priorité vide qui sera modifiée à chaque itération
    q=PriorityQueue{PrimNode{T}}([])
    # Remplissage intial de la file avec des noeuds de Prim dont le min weight est Inf et les parents nothing
    # sauf pour le sommet de départ ou min weight = 0.
    for node in nodes(graph)
        item= node==s ? PrimNode(name(node),data(node),0,nothing):PrimNode(name(node),data(node),Inf,nothing)
        push!(q,item)
    end
    # Tant que tous les noeuds n'ont pas été ajouté à l'arbre : ajouter celui de plus court min_weight et modifier
    # les attributs min_weight et parent de ses voisins pas encore ajoutés à l'arbre
    while not is_empty(q)
        # On repère le noeud le plus proche de l'arbre et on l'ajoute à une liste de noeuds de Prim
        ref=popfirst!(q)
        push!(solution,ref)
        p = PriorityQueue{PrimNode{T}}([])
        # On reconstruit la file de priorité avec les attributs modifiés
        while not is_empty(q)
            item=popfirst!(q)
            if item in neighbours(ref) & weight(edge)<min_weight(item)
                set_min_weight!(item,weight(edge))
                set_parent!(item,ref)
                push!(p,item)
            else
                push!(p,item)
            end
        end
        q=p
    end
    # Retourne : liste des noeuds avec leur parents et poids de l'arête selectionnée dans l'arbre de recouvrement
    # Construction du graphe de recouvrement
    graphe_recouvrement=Graphe("Graphe recouvrement",nodes(graph),[])
    for node in solution
        nodeA=Node(name(node),data(node))
        nodeB=Node(name(parent(node)),data(parent(node)))
        add_edge!(graphe_recouvrement,Edge(nodeA,nodeB))
    end
    graphe_recouvrement
end
