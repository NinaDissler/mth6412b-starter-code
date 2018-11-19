import Base.show

include("prim.jl")
include("kruskal.jl")
include("stsp2graph.jl")
include("RSL.jl")
include("HK.jl")
include("remove_cycles_HKsol.jl")


filename="/home/nina/Documents/cours/Poly/MTH6412B/mth6412b-starter-code-Lab4/instances/stsp/bays29.tsp"
println("Building graph from file")
g=stsp2graph(filename)
racine=nodes(g)[1]
#racine=nodes(g)[end]
choix="kruskal"
#choix="prim"
tk=1.
nb_max_iter=200

println("Construction de la tournée par algorithme RSL")
sommets_RSL=RSL(g,racine,choix)
tournee_RSL=Turn(sommets_RSL)
println("*********************************************")
println("Construction de la tournée par algorithme HK")
println("Constructing the one-tree")
one_tree_HK=HK(g, racine, choix, tk, nb_max_iter)
println("Constructing a turn")
sommets_HK=remove_HKcycles!(preordre(construct_tree(one_tree_HK,racine)))
tournee_HK=Turn(sommets_HK)

println("Tournée minimale approchée par algorithme de Rosenkrantz, Stearns et Lewis")
show(tournee_RSL)
println("*********************************************")
println("")
println("Tournée minimale approchée par algorithme de Held et Karp")
show(tournee_HK)
