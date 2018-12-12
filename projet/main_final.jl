import Base.show
using FileIO
using Images
using ImageView

include("stsp2graph.jl")
include("kruskal.jl")
include("RSL.jl")
include("eval_weights.jl")
include("tsp2tour.jl")
include("bin/tools.jl")

image_file="tsp/instances/abstract-light-painting.tsp"
filename_tour="tours/tour_solution1.tour"
tsp2tour(image_file,filename_tour)
shuffled_image="images/shuffled/abstract-light-painting.png"
reconstructed_image="images/reconstructed/abstract-light-painting-mysolution.png"
reconstruct_picture(filename_tour,shuffled_image,reconstructed_image)
