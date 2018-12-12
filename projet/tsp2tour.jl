using Plots
import Base.push!
plotly()
# include("prim.jl")
include("graph.jl")
include("kruskal.jl")
# include("stsp2graph.jl")
include("RSL.jl")
include("eval_weights.jl")
# include("bin/tools.jl")
include("image_functions.jl")
include("neighbours.jl")

""" Fonction construction d'un tour d'une imag dechiquetée : filename est le chemin menant à l'image au format.tsp"""
# function tsp2tour(filename_image::String,filename_tour::String)
    # Construction du graphe par read_stsp
    # g=stsp2graph(filename_image)

    #Construction manuelle d'une image puis mélande des colonnes
    picture = build_image(50,150)
    spy(picture,show=true,title="Originale")
    shuffled = shuffle_picture(picture)
    spy(shuffled,show=true,title="Mélangée")
    # Construction manuelle du graphe
    nb_row, nb_col = size(picture)
    w = zeros(nb_col, nb_col)
    for j1 = 1 : nb_col
        for j2 = j1 + 1 : nb_col
            w[j1, j2] = compare_columns(shuffled[:, j1], shuffled[:, j2])
            w[j2, j1]=w[j1, j2]
        end
    end
    g=Graph("graphe de l'image",Node{Int64}[],Edge{Int64}[])
    for col in 1:nb_col
        add_node!(g,Node(string("colonne ",col),col))
    end
    for node1 in nodes(g)
        for node2 in nodes(g)
            if node1!=node2
                add_edge!(g,Edge(node1,node2,w[data(node1),data(node2)]))
            end
        end
    end

    # Ajout d'un noeud fictif au graphe
    fictif=Node("fictif",0)
    add_node!(g,fictif)
    # On relie le noeud fictif à tousles autres par des arêtes de poids nuls
    for node in nodes(g)[1:end-1]
        add_edge!(g,Edge(fictif,node,0.))
    end
    # On construit une tournée minimale à partir du noeud fictif
    racine=nodes(g)[end]
    choix="kruskal"
    tour_RSL=RSL(g,racine,choix)
    tournee_RSL=Turn(tour_RSL)

    indexes=[]
    cost=eval_weights(tour_RSL,g)
    for node in tour_RSL
        push!(indexes,copy(data(node)))
    end
    popfirst!(indexes)
    # write.tour(filename_tour,indexes,cost)
    reconstruite=zeros(nb_row,nb_col)
    for col in 1:nb_col
        reconstruite[:,col]=shuffled[:,indexes[col]]
    end
    spy(reconstruite,show=true,title="reconstruite")
# end
