import Base.show

include("../phase1/node.jl")
include("../phase1/edge.jl")
include("../phase1/graph.jl")
include("../phase1/read_stsp.jl")
include("../phase1/main.jl")
include("connected_component.jl")

"Creating graph"
g = main()

"Creating empty connected component"
# c = ConnectedComponent("CC", g)
# show(c)

#will in the end return the connected component which is made by fusion of all connected components of graph
function kruskal()
    #make a list of connected components
    #CC = fusion!(connectedcomponent1, connectedcomponent2)
    #delete both connected components

    #create a new list representing edges of cc
    #make a copy of graph edges
    while #copy of graph edges is not empty
        #find the minimum weight
        #push the corresponding edge to the new list of cc
        #remove the corresponding edge from the copy

#function for fusion of two connected components
