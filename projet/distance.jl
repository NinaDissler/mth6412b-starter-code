function distance(nodeA::AbstractNode,nodeB::AbstractNode,graph)
  for edge in edges(graph)
    distance=Inf
    if nodes(edge)[1]==nodeA && nodes(edges)[2]==nodeB
      distance=weigth(edge)
    elseif nodes(edge)[2]==nodeA && nodes(edges)[1]==nodeB
      distance=weigth(edge)
     end
     end
     end
