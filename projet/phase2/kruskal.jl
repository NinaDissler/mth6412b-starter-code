import Base.show

include("../phase1/main.jl")
include("connected-component.jl")
include("CCfusion.jl")

function kruskal(g::Graph)
    listEdges= edges(g)
    sortedEdges=sort(listEdges, by = x -> weight(x))
    #CC_empty=ConnectedComponent()
    # 1er etape : trier les aretes par poids croissant : ressort la liste d'arêtes de g triées par poids
    sortedGraph=Graph(name(g),nodes(g),sortedEdges)
    # show(sortedGraph)
    # On crée une liste de CC qui ne contient au début aucune CC
    CClist=ConnectedComponent[]
    # On parcoure la liste des arêtes
    step = 1
    while length(sortedEdges)>0
        # println("\nSTEP no.", step)
        # numberBeginning = 0
        # for i in 1: length(CClist)
        #     numberBeginning += length(nodes(CClist[i]))
        # end
        # println(numberBeginning)
        # On sélectionne l'arête de poids min
        edge=edges(sortedGraph)[1]
        # show(edge)
        # j est l'indice de la CC contenant eventuellement le premier noeud de cette arête
        j=1
        # conditionFirstNode indique que le premier noeud de l'arête n'est dans aucune CC déjà construite
        conditionFirstNode=true
        while conditionFirstNode && j<=length(CClist)
            currentCC=CClist[j]
            if (length(CClist) != 0) && name(nodes(edge)[1]) in name.(nodes(currentCC))
                conditionFirstNode=false
                # println("First node of current edge already in CC")
            else
                j+=1
            end
        end
        # println("\n J is ", j)
        # k est l'indice de la CC contenant eventuellement le second noeud de cette arête
        k=1
        # conditionSecondNode indique que le second noeud de l'arête n'est dans aucune CC déjà construite
        conditionSecondNode=true
        while conditionSecondNode && k<=length(CClist)
            currentCC=CClist[k]
            if (length(CClist) != 0) && name(nodes(edge)[2]) in name.(nodes(currentCC))
                conditionSecondNode=false
            else
                k+=1
            end
        end
        # println("\n K is ", k)

        # Si les deux noeuds sont dans la même c'est un cycle on ne l'ajoute nul part
        if j<=length(CClist) && j==k
            # println("Cycle ignoring the edge")
            deleteat!(sortedEdges,1)
        end
        # Si un des noeuds est dans une CC et l'autre dans aucune autre on ajoute à cette CC
        # Condition : (pas même cc) ET (noeudA dans une cc OU noeudB dans une cc) ET (noeudA pas dans une cc OU noeudB pas dans une cc)
        if j!=k && (j<=length(CClist) || k<=length(CClist)) && (conditionFirstNode || conditionSecondNode)
            m=min(j,k)
            add_edge!(CClist[m],edge)
                if m==j
                    add_node!(CClist[m],nodes(edge)[2])
                else
                    add_node!(CClist[m],nodes(edge)[1])
                end
            # println("Adding edge", name.(nodes(edge)), "to CClist")
            # show(CClist[m])
            deleteat!(sortedEdges,1)
            #at the end of everything?
        end

        # Si les noeuds sont dans deux CC différentes on les fusionne en ajoutant l'arête et on ajoute la nouvelle a la liste
        # On enlève les anciennes CC de la liste
        # Condition : pas même CC ET (noeudA dans une cc ET noeudB dans une cc)
        if j!=k && (j<=length(CClist) && k<=length(CClist))
            newCC=CCfusion(CClist[j],CClist[k])
            add_edge!(newCC,edge)
            # println("Adding fusion of")
            # show(CClist[j])
            # println( "and")
            # show(CClist[k])
            # println(" to CClist")
            deleteat!(CClist,max(j,k))
            deleteat!(CClist,min(j,k))
            push!(CClist,newCC)
            # show(CClist[length(CClist)])
            deleteat!(sortedEdges,1)
        end

        # Si l'arête n'est dans aucune CC (ie ses deux noeuds ne sont pas dans une CC) on crée une CC avec et on l'enlève de la liste
        if conditionFirstNode && conditionSecondNode
            push!(CClist,ConnectedComponent(nodes(edge),[edge]))
            # println("Adding to CClist new CC: ")
            # show(ConnectedComponent(nodes(edge),[edge]))
            deleteat!(sortedEdges,1)
        end

        # numberEnd = 0
        # for i in 1: length(CClist)
        #     numberEnd += length(nodes(CClist[i]))
        # end
        # println(numberEnd)
        # step += 1
    end
    # return(CClist[length(CClist)])
    # println(length(CClist))
    return(CClist[1]);
end
