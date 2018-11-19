include("tournee.jl")

""" Enlève les cycles dans une tournée minimale approchée de Held et Karp"""
function remove_HKcycles!(sommets::Vector)
    removed=0
    for i in 1:length(sommets)
        node=sommets[i-removed]
        if length(findall(x -> x==node, sommets))==2
            deleteat!(sommets,i-removed)
            removed +=1
        end
    end
    sommets
end
