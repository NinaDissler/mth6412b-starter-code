include("node.jl")
include("edge.jl")
include("graph.jl")

a = Node("a", 1)
b = Node("b", 2)
c = Node("c", 3)
d = Node("d", 4)
e = Node("e", 5)
f = Node("f", 6)
g = Node("g", 7)
h = Node("h", 8)
i = Node("i", 9)
e1 = Edge(a,b,4)
e2 = Edge(b,c,8)
e3 = Edge(c,d,7)
e4 = Edge(d,e,9)
e5 = Edge(e,f,10)
e6 = Edge(f,g,2)
e7 = Edge(g,h,1)
e8 = Edge(h,a,8)
e9 = Edge(h,b,11)
e10 = Edge(h,i,7)
e11 = Edge(i,g,6)
e12 = Edge(i,c,2)
e13 = Edge(c,f,4)
e14 = Edge(d,f,14)

#For a tree
# e1 = Edge(a,b,4)
# e2 = Edge(b,e,8)
# e3 = Edge(a,c,7)
# e4 = Edge(d,a,9)
# e5 = Edge(b,f,10)
# e6 = Edge(f,h,2)
# e7 = Edge(g,d,1)
# e8 = Edge(f,i,8)

graphico = Graph("Small graph", [a,b,c,d,e,f,g,h,i], [e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,e11,e12,e13,e14])

# treeA=Tree("a",a,nothing,nothing)
# treeH=Tree("h",h,nothing,nothing)
# treeI=Tree("i",i,nothing,nothing)
# treeG=Tree("g",g,nothing,nothing)
# treeB=Tree("b",b,nothing,nothing)
#
# set_parent!(treeH,treeA)
# set_parent!(treeG,treeH)
# set_parent!(treeI,treeH)
# set_parent!(treeB,treeA)
#
# add_son!(treeA,treeH)
# add_son!(treeA,treeB)
# add_son!(treeH,treeI)
# add_son!(treeH,treeG)
