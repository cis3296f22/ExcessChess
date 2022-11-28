tool
extends Container

#Todo: inherit sizes from board
var WIDTH = 8
var HEIGHT = 8

var contents = [] #.resize(WIDTH*HEIGHT)

var green_square = preload("res://assets/board/green_square.png")
var pawn = preload("res://assets/pieces/white_pawn.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	_setup()

func resize(width, height):
	WIDTH = width
	HEIGHT = height
	_setup()

func _setup():
	var tile_size = Vector2(green_square.get_width(), green_square.get_height())
	var piece_size = Vector2(pawn.get_width(),pawn.get_height())
	#The amount of space to include on each size of the piece, to center it in a square
	var piece_size_side_gap = (tile_size.x - piece_size.x)/2 #NOTE: This will likely cause issues if the gap is odd 
	#The hight to shift the piece up to make the bottom flush with the bottom of the square (instead of tops flush)
	var height_shift = (tile_size.y - piece_size.y)
	
	#Throw out any existing children
	for n in get_children():
		n.queue_free()
	contents = []
	
	for _i in range(HEIGHT):
		for _j in range(WIDTH):
			var x = TextureRect.new()
			x.texture = null
			x.set_mouse_filter(Control.MOUSE_FILTER_IGNORE) #Allow clicks on the button below
			contents.append(x) #Save to list of children
			add_child(x) #And add it to scene tree
			x.rect_position = Vector2(tile_size.x *_j + piece_size_side_gap, tile_size.y*_i + height_shift) #The apply the shift
func show_child(child:int, tex):
	contents[child].texture = tex
	

func as_string():
	var result = ""
	result += String(WIDTH)
	result += " "
	result += String(HEIGHT)
	result += " "
#	print("Result: ",result)
	for piece in get_children():
		if piece.texture == null:
			#Blank space
			result += "_ "
		else:
			var tex = piece.texture.load_path
			if("white_pawn" in tex):
				result += "white_pawn "
			elif("white_rook" in tex):
				result += "white_rook "
			elif("white_knight" in tex):
				result += "white_knight "
			elif("white_bishop" in tex):
				result += "white_bishop "
			elif("white_king" in tex):
				result += "white_king "
			elif("white_queen" in tex):
				result += "white_queen "
		#Black pieces
			elif("black_pawn" in tex):
				result += "black_pawn "
			elif("black_rook" in tex):
				result += "black_rook "
			elif("black_knight" in tex):
				result += "black_knight "
			elif("black_bishop" in tex):
				result += "black_bishop "
			elif("black_king" in tex):
				result += "black_king "
			elif("black_queen" in tex):
				result += "black_queen "
		#unknown
			else:
				result += "_ "
	return result


func from_string(string):
	#split the string by whitespace. See:
	# https://github.com/godotengine/godot/issues/29554#issuecomment-500126883
	var r = RegEx.new()
	r.compile("\\S+") # negated whitespace character class
	var count = -2 #So forst peice will be 0
	var w
	var h
	for m in r.search_all(string):
		var token = m.get_string()
		
		if(count == -2): #width
			count += 1
			w = int(token)
			if(w < 1):
				w=1 #TODO: raise error
			continue
		if(count == -1): #height
			count += 1
			h = int(token)
			if(h < 1):
				h=1 #TODO: raise error
			get_parent().resize(w,h)
			continue #TODO: resize/validate based on these values.
		
		if token == "_":
			show_child(count,null)
		elif token == "white_pawn":
			show_child(count, Util.white_pawn_tex)
		elif token == "white_rook":
			show_child(count, Util.white_rook_tex)
		elif token == "white_knight":
			show_child(count, Util.white_knight_tex)
		elif token == "white_bishop":
			show_child(count, Util.white_bishop_tex)
		elif token == "white_king":
			show_child(count, Util.white_king_tex)
		elif token == "white_queen":
			show_child(count, Util.white_queen_tex)
	#Black pieces
		elif token == "black_pawn":
			show_child(count, Util.black_pawn_tex)
		elif token == "black_rook":
			show_child(count, Util.black_rook_tex)
		elif token == "black_knight":
			show_child(count, Util.black_knight_tex)
		elif token == "black_bishop":
			show_child(count, Util.black_bishop_tex)
		elif token == "black_king":
			show_child(count, Util.black_king_tex)
		elif token == "black_queen":
			show_child(count, Util.black_queen_tex)
	#unknown
		else:
			show_child(count, null)
		
		count += 1
	#End loop
