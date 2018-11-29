#include("graph.jl")
#include("kruskal.jl")
#include("prim.jl")
#include("tree.jl")
include("degrees.jl")
include("clear_cyclic_edges.jl")
include("clear_doublons_edges.jl")

""" Algorithme de Held et Karp de calcul d'une tournée minimale approchée"""
function HK(graph::AbstractGraph, racine::AbstractNode, choix::String, tk::Float64, nb_max_iter::Int64)
        clear_cyclic_edges!(graph)
        clear_doublons_edges!(graph)
    K=0
    N=nb_nodes(graph)
    pi_k=Vector{Float64}()
    for i = (1:N)
      push!(pi_k,0)
    end
    @test length(pi_k)==N
    Wopt=-Inf
    condition=true
    if racine==nodes(graph)[1]
        deletednode=nodes(graph)[end]
    else
        deletednode=nodes(graph)[1]
    end
    delete_node!(graph,deletednode)
    while true
        #println("HK Itération : ",K, " Avancement : ", 100* K/nb_max_iter, "%")
        #######################################################################
        #println("Construction du 1-tree")

        # Adaptation des poids des arêtes avec les pi : cij=cij+pi_k[i]+pi_k[j]
        # et suppression des arête connectées au noeud supprimé
        indexes=Vector{Int64}()
        newedges=Vector{Edge{Array{Float64,1}}}()
        for i in 1:nb_edges(graph)
            edge=edges(graph)[i]
            if deletednode in nodes(edge)
                    push!(indexes,i)
            else
                    pi_k_i=pi_k[     findall(x->x==nodes(edge)[1],nodes(graph))[1]    ]
                    pi_k_j=pi_k[     findall(x->x==nodes(edge)[2],nodes(graph))[1]    ]
                    newedge=Edge(nodes(edge)[1],nodes(edge)[2],weight(edge) + pi_k_i + pi_k_j)
                    push!(newedges,newedge)
            end
        end
        g=Graph(name(graph),nodes(graph),newedges)

        # Supression d'un noeud qui n'est pas la racine du MST
        @test (nb_nodes(g)==N-1)
        clear_cyclic_edges!(g)
        clear_doublons_edges!(g)
        # Construction du MST
        MST = choix=="prim" ? prim(g,nodes(g)[1]) : kruskal(g)
        @test (nb_nodes(MST)==N-1)
        # Ajout du noeud supprimé au début
        add_node!(MST,deletednode)
        # On le relie par deux arêtes de poids min
        index_1=0
        distmin1=Inf
        for i in 1:N-1
                if distance(deletednode,nodes(g)[i],graph)<distmin1
                        index_1=i
                        distmin1=distance(deletednode,nodes(g)[i],graph)
                end
        end
        index_2=0
        distmin2=Inf
        for i in 1:N-1
                if distance(deletednode,nodes(g)[i],graph)<distmin2 && i!=index_1
                        index_2=i
                        distmin2=distance(deletednode,nodes(g)[i],graph)
                end
        end
        # On cherche celles de poids min
        edgetoadd1=Edge(deletednode,nodes(g)[index_1],distmin1)
        edgetoadd2=Edge(deletednode,nodes(g)[index_2],distmin2)
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
        step=1./sqrt(K)
        pi_k = pi_k + step*vk
        K+=1
        #println("***************************")
    end
end
