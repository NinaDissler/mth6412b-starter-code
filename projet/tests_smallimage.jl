using Random
import Base.push!
using Gadfly

include("image_functions.jl")
include("node.jl")
include("edge.jl")
include("graph.jl")
include("kruskal.jl")
include("RSL.jl")
include("eval_weights.jl")
include("graph2tour.jl")
include("neighbours.jl")

picture=build_image(100,100)
shuffled=shuffle_picture(picture)
# Construction manuelle du graphe
nb_row, nb_col = size(picture)
w = zeros(nb_col, nb_col)
for j1 = 1 : nb_col
    for j2 = j1 + 1 : nb_col
        w[j1, j2] = compare_columns_bis(shuffled[:, j1], shuffled[:, j2])
        w[j2, j1]=w[j1, j2]
    end
end
distmax=maximum(w)
g=Graph("graphe de l'image mélangée",Node{Int64}[],Edge{Int64}[])
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
# On relie le noeud fictif à tous les autres par des arêtes de poids élevés
for node in nodes(g)[1:end-1]
    add_edge!(g,Edge(fictif,node,20*distmax))
end
# On construit une tournée minimale à partir du noeud fictif
racine=nodes(g)[end]
choix="kruskal"
tour=RSL(g,racine,choix)
indexes=[]
cost=eval_weights(tour,g)
for node in tour
    push!(indexes,copy(data(node)))
end
popfirst!(indexes)
reconstruite=zeros(nb_row,nb_col)
for col in 1:nb_col
    reconstruite[:,col]=shuffled[:,indexes[col]]
end

Gadfly.spy(picture,Guide.title("Image originale"))
Gadfly.spy(shuffled,Guide.title("Image déchiquetée"))
Gadfly.spy(reconstruite,Guide.title("Image reconstruite"))
