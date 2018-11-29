import Base.show

include("prim.jl")
include("kruskal.jl")
include("stsp2graph.jl")
include("RSL.jl")
include("HK.jl")
include("remove_cycles_HKsol.jl")
include("eval_weights.jl")


filename="./instances/stsp/bays29.tsp"
println("Building graph from file")
graph_init=stsp2graph(filename)
save=copy(graph_init)
racine=nodes(graph_init)[1]
#racine=nodes(g)[end]
choix="kruskal"
#choix="prim"
tk=1.
nb_max_iter=2000
println("Construction de la tournée par algorithme RSL")
sommets_RSL=RSL(graph_init,racine,choix)
tournee_RSL=Turn(sommets_RSL)
println("*********************************************")
# println("Construction de la tournée par algorithme HK")
# println("Constructing the one-tree")
# one_tree_HK=HK(graph_init, racine, choix, tk, nb_max_iter)
# println("Constructing a turn")
# sommets_HK=remove_HKcycles!(preordre(construct_tree(one_tree_HK,racine)))
# tournee_HK=Turn(sommets_HK)
# eval_weights(sommets_HK,graph_init)
#
println("Tournée minimale approchée par algorithme de Rosenkrantz, Stearns et Lewis")
show(tournee_RSL)
eval_weights(tournee_RSL.items, graph_init)
# println("*********************************************")
# println("")
# println("Tournée minimale approchée par algorithme de Held et Karp")
# show(tournee_HK)
