""" Construit une matrice représentant une image avec un trait"""
function build_image(nb_rows::Int64,nb_columns::Int64)
    image=zeros(nb_rows,nb_columns)
    for i in 1:nb_rows
        for j in 1:nb_columns
            if j-(nb_rows/5)<i && i<j+(nb_rows/5)
                image[i,j]=1+i+j
            end
        end
    end
    return image
end

"""Shuffle the columns of an image randomly or using a given permutation."""
function shuffle_picture(picture::Matrix{Float64}, permutation=[])
	nb_row, nb_col = size(picture)
	shuffled_picture = zeros(picture)
    if permutation == []
    	permutation = shuffle(1:nb_col)
    end
	for col = 1 : nb_col
		shuffled_picture[:,col] = copy(picture[:,permutation[col]])
	end
	return shuffled_picture
end

"""Compute the similarity score between two columns of pixels in an image."""
function compare_columns(col1, col2)
	score = 0
	nb_row = length(col1)
	for row = 1 : nb_row
		score += abs(col1[row]- col2[row])
	end
	return score
end

"""Compute the similarity score between two pixels."""
function compare_pixels(p1, p2)
	r1, g1, b1 = red(p1), green(p1), blue(p1)
	r2, g2, b2 = red(p2), green(p2), blue(p2)
	return abs(r1-r2) + abs(g1-g2) + abs(b1-b2)
end
