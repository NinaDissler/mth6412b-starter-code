import Base.show
using FileIO
using Images
using ImageView
using ImageMagick

include("prim.jl")
include("kruskal.jl")
include("stsp2graph.jl")
include("RSL.jl")
include("eval_weights.jl")

function reconstruct(filename::String)
    g=stsp2graph(filename)
    fictif=Node("fictif",0)
    add_node!(g,fictif)
    racine=nodes(g)[1]
    choix="kruskal"
    sommets_RSL=RSL(g,racine,choix)
    tournee_RSL=Turn(sommets_RSL)
    indexes=Array{Int}()
    cost=eval_weights(tournee_RSL,g)
    for node in sommets_RSL
        push!(indexes,copy(data(node)))
    end
    write.tour("tour_solution",indexes,cost)
    tour_filename="tour_solution"
    reconstruct_picture(tour_filename,input_image,output_name)
end
