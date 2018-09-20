import Base.show

include("node.jl")
include("edge.jl")
include("graph.jl")
include("read_stsp.jl")

filename="./instances/stsp/bayg29.tsp"

hdr=read_header(filename)

""" Les noeuds dans la fonction read_nodes sont renvoyés sous forme d'un dictionnaire"""
dict_nodes=read_nodes(hdr,filename)

""" La fonction read_edges renvoie les arretes dans une structure (entier,entier,string)
qu'il faut convertir en noeud,noeud,entier"""
list_edges=read_edges(hdr,filename)

""" Initialisation du graphe"""

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
