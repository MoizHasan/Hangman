class ManPictures

def initialize
@man_pictures = []
@man_pictures[0] = ""

@man_pictures[1] = %q{
______
|    |
|   
|    
|   
}

@man_pictures[2] = %q{
______
|    |
|    O
|    
|   
}

@man_pictures[3] = %q{
______
|    |
|   \O
|    
|   
}

@man_pictures[4] = %q{
______
|    |
|   \O/
|    
|   
}

@man_pictures[5] = %q{
______
|    |
|   \O/
|    |
|   
}

@man_pictures[6] = %q{
______
|    |
|   \O/
|    |
|   / 
}

@man_pictures[7] = %q{
______
|    |
|   \O/
|    |
|   / \
}

end

def get_man_pictures
	@man_pictures
end

end