#include("graph.jl")
#include("kruskal.jl")
#include("prim.jl")
#include("tree.jl")
include("degrees.jl")
include("clear_cyclic_edges.jl")
include("clear_doublons_edges.jl")

""" Algorithme de Held et Karp de calcul d'une tournée minimale approchée"""
function HK(graph::AbstractGraph, root::AbstractNode, choix::String, tk::Float64, nb_max_iter::Int64)
        clear_cyclic_edges!(graph)
        clear_doublons_edges!(graph)
    K=0
    N=nb_nodes(graph)
    pi_k=Vector{Float64}()
    for i = (1:N)
      push!(pi_k,0)
    end
    Wopt=-Inf
    condition=true
    while true
        #println("HK Itération : ",K, " Avancement : ", 100* K/nb_max_iter, "%")
        #######################################################################
        #println("Construction du 1-tree")
        # Copie du graphe
        g=copy(graph)
        # Supression d'un noeud qui n'est pas la racine du MST
        if root==nodes(g)[1]
            deletednode=copy(nodes(g)[end])
        else
            deletednode=copy(nodes(g)[1])
        end
        delete_node!(g,deletednode)
        @test (nb_nodes(g)==N-1)
        # Adaptation des poids des arêtes avec les pi : cij=cij+pi_k[i]+pi_k[j]
        # et suppression des arête connectées au noeud supprimé
        indexes=Vector{Int64}()
        for i in 1:nb_edges(g)
            edge=edges(g)[i]
            if deletednode in nodes(edge)
                    push!(indexes,i)
            else
                    pi_k_i=pi_k[findall(x->x==nodes(edge)[1],nodes(g))]
                    pi_k_j=pi_k[findall(x->x==nodes(edge)[2],nodes(g))]
                    set_weight!(edge) = weight(edge) + pi_k_i + pi_k_j
            end
        end
        deleteat!(g.edges,indexes)
        @test nb_edges(g)==nb_edges(graph)-length(neighbours(deletednode,graph))
        # Construction du MST
        MST = choix=="prim" ? prim(g,nodes(g)[1]) : kruskal(g)
        @test (nb_nodes(MST)==N-1)
        # Ajout du noeud supprimé au début
        add_node!(MST,deletednode)
        # On le relie par deux arêtes de poids min
        # Selection des arêtes potentielles ie reliées au sommet dans graphe init
        possible_edges=copy(edges(graph)[indexes])
        # On cherche celles de poids min
        edgetoadd1=possible_edges[argmin(weight.(possible_edges))]
        deleteat!(possible_edges,argmin(weight.(possible_edges)))
        edgetoadd2=possible_edges[argmin(weight.(possible_edges))]
        # Ajout au MST (toujours de type graph)
        add_edge!(MST,edgetoadd1)
        add_edge!(MST,edgetoadd2)

        one_tree=MST
        # Tests sur le nombre d'arêtes et de noeuds dans le one tree
        @test (nb_nodes(one_tree)==N)
        @test (nb_edges(one_tree)==N)
        ######################################################################
        #println("Adaptation des poids")
        # Calcul de z(pik)
        size_one_tree=sum(weight.(edges(one_tree)))
        z=size_one_tree-2*sum(pi_k)
        Wopt=max(Wopt,z)
        vk=degrees(one_tree).-2
        # Si tous les degrés sont égaux à 2 c'est un tour dans un 1 tree donc optimal »: on s'arrête
        if vk==zeros(sizeof(vk)) || K==nb_max_iter
                return one_tree
        end
        # Condition d'arrêt : ne pas dépasser 50 itérations

        # Choix du pas tk
        #tk=tk*0.999
        pi_k = pi_k + tk*vk
        K+=1
        #println("***************************")
    end
end
