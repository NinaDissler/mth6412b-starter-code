# import Base.show
using FileIO
# using Images
# using ImageView

include("node.jl")
include("edge.jl")
include("graph.jl")
include("tsp2graph.jl")
include("read_stsp.jl")
include("kruskal.jl")
include("RSL.jl")
include("eval_weights.jl")
include("graph2tour.jl")
include("../bin/tools.jl")
include("neighbours.jl")

image_file="../tsp/instances/abstract-light-painting.tsp"
filename_tour="../tsp/tours/tour_solutiontest.tour"
shuffled_file="../images/shuffled/abstract-light-painting.png"
reconstructed_image="../images/reconstructed/mysolution1.png"
println("//Construction du graphe")
g=tsp2graph(image_file)
println("********************************")
println("//Construction et écriture du tour")
graph2tour(g,filename_tour)
println("********************************")
reconstruct_picture(filename_tour,shuffled_file,reconstructed_image)
