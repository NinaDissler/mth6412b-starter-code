""" Fonction pour la compression des chemins"""
function compression_des_chemins!(tree::AbstractTree{})
    flag = true
    sons(tree)==nothing && return tree
    for son in sons(tree)
        if sons(son) != nothing
            flag=false
        end
    end
    flag==true && return tree
    for son in sons(tree)
        compression_des_chemins!(son)
        for son_of_son in sons(son)
            set_parent!(son_of_son,tree)
            add_son!(tree,son_of_son)
        end
        delete_sons!(son)
    end
end
