using Test

include("prim.jl")
include("kruskal.jl")
include("preordre.jl")

""" Algorithme de Rosenkrantz, Stearns et Lewis de calcul d'une tournée minimale approchée"""
function RST(graph::AbstractGraph{T},root::AbstractNode{T},choice::Union{"prim","kruskal"}) where T
  " Calcul d'un arbre de recouvrement minimal avec l'algo de son choix "
  println("Constructing the MST")
  " Prim : renvoie un graphe de recouvrement de type Graph"
  choice=="prim" && MST=prim(graph,root)
  " Kruskal : renvoie une composante connexe de type ConnectedComponent"
  choice=="kruskal" && MST=kruskal(graph)
  
    
  @test (nb_nodes(MST)!=0)
  @test (nb_edges(MST)!=0)
  
  "Construction d'un arbre à partir de MST"
  println("Constructing the tree")
  tree=consctruct_tree(MST, root)

  " Ordonancement des sommets par parcours en préordre du MST "
  println("Sorting the nodes")
  sommets=preordre(MST)
  @test length(sommets)==nb_nodes(graph)
  sommets
end
