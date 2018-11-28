import Base.show

""" Fusionne deux composantes connexes """
function CCfusion(CC1::ConnectedComponent,CC2::ConnectedComponent)
    newnodes=vcat(nodes(CC1),nodes(CC2))
    newedges=vcat(edges(CC1),edges(CC2))
    newname=string(name(CC1),name(CC2))
    CCfus=ConnectedComponent(newname,newnodes,newedges)
    return CCfus
end
