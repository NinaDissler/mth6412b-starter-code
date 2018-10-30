function distance(nodeA::AbstractNode,nodeB::AbstractNode,graph::AbstractGraph)
  distance = Inf
  for edge in edges(graph)
    if nodes(edge)[1] == nodeA && nodes(edge)[2] == nodeB
      distance = weight(edge)
    elseif nodes(edge)[2] == nodeA && nodes(edge)[1] == nodeB
      distance = weight(edge)
    end
  end
  distance
end
