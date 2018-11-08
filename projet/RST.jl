using Test

include("prim.jl")
include("kruskal.jl")
include("preordre.jl")

""" Algorithme de Rosenkrantz, Stearns et Lewis de calcul d'une tournée minimale approchée"""
function RST(graph::AbstractGraph{T},root::AbstractNode{T},choice::Union{"prim","kruskal"}) where T
  " Calcul d'un arbre de recouvrement minimal avec l'algo de son choix "
  choice=="prim" && MST=prim(graph,root)
  choice=="kruskal" && MST=kruskal(graph)
  
  @test is_not_empty(MST)
  
  " Ordonancement des sommets par parcours en préordre du MST "
  sommets=preordre(MST)
  
  @test length(sommets)==nb_nodes(graph)
  
  return sommets
end
