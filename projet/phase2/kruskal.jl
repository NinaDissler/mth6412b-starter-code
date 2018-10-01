import Base.show

include("main.jl")
include("connected-component.jl")
include("CCfusion.jl")

function kruskal(g::Graph)
    #CC_empty=ConnectedComponent()
    # 1er etape : trier les aretes par poids croissant : ressort la liste d'arêtes de g triées par poids
    sortedGraph=Graph(name(g),nodes(g),sortedEdges)
    # On crée une liste de CC qui ne contient au début aucune CC
    CClist=ConnectedComponent[]
    # On parcoure la liste des arêtes
    while length(sortedEdges)>0
        # On sélectionne l'arête de poids min
        edge=sortedEdges[1]
        # j est l'indice de la CC contenant eventuellement le premier noeud de cette arête
        j=1
        # conditionFirstNode indique que le premier noeud de l'arête n'est dans aucune CC déjà construite
        conditionFirstNode=true
        while conditionFirstNode && j<=length(CClist)
            if nodes(edge)[1] in nodes(CClist[j])
                conditionFirstNode=false
            else
                j+=1
            end
        end
        # k est l'indice de la CC contenant eventuellement le second noeud de cette arête
        k=1
        # conditionSecondNode indique que le second noeud de l'arête n'est dans aucune CC déjà construite
        conditionSecondNode=true
        while conditionSecondNode && k<=length(CClist)
            if nodes(edge)[2] in nodes(CClist[k])
                conditionSecondNode=false
            else
                k+=1
            end
        end
        # Si l'arête n'est dans aucune CC (ie ses deux noeuds ne sont pas dans une CC) on crée une CC avec et on l'enlève de la liste
        if conditionFirstNode && conditionSecondNode
            push!(CClist,ConnectedComponent(nodes(edge),edge))
            pop!(sortedEdges(edge))
        end

        # Si les deux noeuds sont dans la même c'est un cycle on ne l'ajoute nul part
        if j<=length(CClist) && j=k
            pop!(sortedEdges(edge))
        end
        # Si un des noeuds est dans une CC et l'autre dans aucune autre on ajoute à cette CC
        # Condition : (pas même cc) ET (noeudA dans une cc OU noeudB dans une cc) ET (noeudA pas dans une cc OU noeudB pas dans une cc)
        if j!=k && (j<=length(CClist) || k<=length(CClist)) && (conditionFirstNode || conditionSecondNode)
            m=min(j,l)
            add_edge!(CClist[m],edge)
                if m=j
                    add_node!(CClist[m],nodes(edge)[1])
                else
                    add_node!(CClist[m],nodes(edge)[2])
                end
            pop!(sortedEdges(edge))
        end

        # Si les noeuds sont dans deux CC différentes on les fusionne en ajoutant l'arête et on ajoute la nouvelle a la liste
        # On enlève les anciennes CC de la liste
        # Condition : pas même CC ET (noeudA dans une cc ET noeudB dans une cc)
        if j!=k && (j<=length(CClist) && k<=length(CClist))
            newCC=CCfusion(CClist[j],CClist[k])
            deleteat!(CClist,j)
            deleteat!(CClist,k)
            push!(CClist,newCC)
            pop!sortedEdges(edge))
        end
    return(CClist[1])
end
