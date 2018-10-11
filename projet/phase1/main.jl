import Base.show

include("node.jl")
include("edge.jl")
include("graph.jl")
include("read_stsp.jl")
include("../phase2/kruskal.jl")
filename="./instances/stsp/bayg29.tsp"

function main(filename)
    """ Fichier a trasncrire """

    hdr=read_header(filename)

    """ Lecture des noeuds du fichier.tsp -> dictionnaire[noeud]=> data"""
    dict_nodes=read_nodes(hdr,filename)

    """ Lecture des arretes du fichier.tsp ->
    liste contenant des tuple (entier entier string) representant (noeud, noeud, poids)"""
    list_edges=read_edges(hdr,filename)

    """ Initialisation du graphe avec le premier noeud et la première arrête convertis"""

    g=Graph("MyGraph",[Node(string(1),dict_nodes[1])],[Edge(Node(string(list_edges[1][1]+1),dict_nodes[list_edges[1][1]+1]),Node(string(list_edges[1][2]+1),dict_nodes[list_edges[1][2]+1]),parse(Int64,list_edges[1][3]))])

    """ Ajout des noeuds"""
    i=2
    for i in 2:length(dict_nodes)
        add_node!(g,Node(string(i),dict_nodes[i]))
    end

    """ Ajout des arretes"""
    i=2
    for i in 2:length(list_edges)
        firstnode=Node(string(list_edges[i][1]+1),dict_nodes[list_edges[i][1]+1])
        secondnode=Node(string(list_edges[i][2]+1),dict_nodes[list_edges[i][2]+1])
        edgeweight=parse(Int64,list_edges[i][3])
        add_edge!(g,Edge(firstnode,secondnode,edgeweight))
    end

    """ Un arbre de recouvrement minimal """
    show(kruskal(g))
end
