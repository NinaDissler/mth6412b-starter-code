import Base.show
using Test
import Base.length


# include("node.jl")
# include("edge.jl")
# include("graph.jl")
# include("read_stsp.jl")

function tsp2graph(filename)
    """ Fichier a transcrire """
    hdr=read_header(filename)

    """ Lecture des arretes du fichier.tsp ->
    liste contenant des tuple (entier entier string) representant (noeud, noeud, poids)"""
    list_edges=read_edges(hdr,filename)

    """ Initialisation du graphe """

    g=Graph("MyGraph",Node{Int64}[],Edge{Int64}[])

    """ Ajout des arretes"""
    for i in 1:length(list_edges)
        firstnode=Node(string("colonne ",list_edges[i][1]+1),list_edges[i][1]+1)
        secondnode=Node(string("colonne ",list_edges[i][2]+1),list_edges[i][2]+1)
        edgeweight=list_edges[i][3]
        add_edge!(g,Edge(firstnode,secondnode,edgeweight))
    end
    """ Ajout des noeuds à partir des arêtes """
    for edge in edges(g)
        if !(nodes(edge)[1] in nodes(g))
            add_node!(g,nodes(edge)[1])
        end
        if !(nodes(edge)[2] in nodes(g))
            add_node!(g,nodes(edge)[2])
        end
    end
    g
end
