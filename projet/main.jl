import Base.show

include("main_4.jl")
include("prim.jl")
include("kruskal.jl")
include("stsp2graph.jl")


filename="./instances/stsp/bays29.tsp"
g=stsp2graph(filename)
show(kruskal(g))
show(prim(g,nodes(g)[1]))
