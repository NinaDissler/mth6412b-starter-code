import Base.popfirst!
import Base.push!
#Algorithme de Prim
include("prim_node.jl")
include("prim_priority_queue.jl")
include("graph.jl")

function prim(graph::AbstractGraph{T},s::AbstractNode{T}) where T
    # Initialisation d'une liste des résultats
    solution=Vector{PrimNode{T}}([])
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
    # Tant que tous les noeuds n'ont pas été ajouté à l'arbre : ajouter celui de plus court min_weight et modifier
    # les attributs min_weight et parent de ses voisins pas encore ajoutés à l'arbre
    while is_empty(q)
        # On repère le noeud le plus proche de l'arbre et on l'ajoute à une liste de noeuds de Prim
        ref=popfirst!(q)
        push!(solution,ref)
        p = PrimPriorityQueue{T}([])
        # On reconstruit la file de priorité avec les attributs modifiés
        while not is_empty(q)
            item=popfirst!(q)
            #TO-DO implement neighbours
            if item in neighbours(ref) && weight(edge(item,ref))<min_weight(item)
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
    graphe_recouvrement=Graph("Graphe recouvrement",nodes(graph),Vector{Edge{T}}([]))
    for node in solution
        nodeA=Node(name(node),data(node))
        nodeB=Node(name(parent(node)),data(parent(node)))
        add_edge!(graphe_recouvrement,Edge(nodeA,nodeB))
    end
    graphe_recouvrement
end

function neighbours(pnode::AbstractNode{T},graph::AbstractGraph{T}) where T
   list=Vector{AsbtractNode}([])
   for item in nodes(graph)
        for edge in edges(graph)
            if nodeA(edge)==pnode && nodeB(edge)==item
                push!(list,item)
            elseif nodeB(edge)==pnode && nodeA(edge)==item
                push!(list,item)
            end
        end
    end
    list
end
