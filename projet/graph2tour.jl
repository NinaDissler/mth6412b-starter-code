# include("kruskal.jl")
# include("RSL.jl")
# include("eval_weights.jl")
# include("../bin/tools.jl")
# include("neighbours.jl")

""" Construit un tour depuis le graphe d'une image dechiquetée"""
function graph2tour(g::Graph,filename_tour::String)
    # # Ajout d'un noeud fictif au graphe
    # fictif=Node("fictif",0)
    # add_node!(g,fictif)
    # # On relie le noeud fictif à tousles autres par des arêtes de poids élevés
    # # distmax=maximum(weight.(edges(g)))
    # for node in nodes(g)[1:end-1]
    #     add_edge!(g,Edge(fictif,node,Inf))
    # end
    # On construit une tournée minimale à partir du noeud fictif
    racine=nodes(g)[end]
    choix="kruskal"
    tour_RSL=RSL(g,racine,choix)
    tournee_RSL=Turn(tour_RSL)
    show(tournee_RSL)
    indexes=Array{Int64}([])
    cost=convert(Float32,eval_weights(tour_RSL,g))
    for node in tour_RSL
        push!(indexes,copy(data(node)))
    end
    write_tour(filename_tour,indexes,cost)
end
