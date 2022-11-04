tool
extends Container


export var DEFUALT_WIDTH = 8
export var DEFUALT_HEIGHT = 8
var contents = [] #.resize(DEFUALT_WIDTH*DEFUALT_HEIGHT)

var green_square = preload("res://assets/board/green_square.png")
var pawn = preload("res://assets/pieces/white_pawn.png")

# Called when the node enters the scene tree for the first time.
func _ready():
#	print(pawn.get_height())
	var tile_size = Vector2(green_square.get_width(), green_square.get_height())
	var piece_size = Vector2(pawn.get_width(),pawn.get_height())
	#The ammount of space to include on each size of the piece, to center it in a square
	var piece_size_side_gap = (tile_size.x - piece_size.x)/2 #NOTE: This will likely cause issues if the gap is odd 
	#The hight to shift the piece up to make the bottom flush with the bottom of the square (instead of tops flush)
	var height_shift = (tile_size.y - piece_size.y)
	
	
	for _i in range(DEFUALT_HEIGHT):
		for _j in range(DEFUALT_WIDTH):
			var x = TextureRect.new()
			x.texture = green_square
			x.set_modulate(Color(1,1,1,0)) #Set alpha to 0, so it's invisible
			x.set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
#			x.set_id( (i*DEFUALT_WIDTH) + j)
#			x.texture_hover = green_square
			contents.append(x)
			add_child(x)
			x.rect_position = Vector2(tile_size.x *_j + piece_size_side_gap, tile_size.y*_i + height_shift)

func show_child(child:int, tex):
	contents[child].texture = tex
	contents[child].set_modulate(Color(1,1,1,1))
	
#func child_pressed(bound):
#	print("Child ", bound, " Pressed!")

func as_string():
	var result = ""
	result += String(DEFUALT_WIDTH)
	result += " "
	result += String(DEFUALT_HEIGHT)
	result += " "
#	print("Result: ",result)
	for piece in get_children():
		if piece.texture == null:
			pass
		else:
			var tex = piece.texture.load_path
			if("white_pawn" in tex):
				result += "wp "
			elif("white_rook" in tex):
				result += "wr "
			elif("white_knight" in tex):
				result += "wk "
			elif("white_bishop" in tex):
				result += "wb "
			elif("white_king" in tex):
				result += "wk "
			elif("white_queen" in tex):
				result += "wq "
		#Black pieces
			elif("black_pawn" in tex):
				result += "bp "
			elif("black_rook" in tex):
				result += "br "
			elif("black_knight" in tex):
				result += "bk "
			elif("black_bishop" in tex):
				result += "bb "
			elif("black_king" in tex):
				result += "bk "
			elif("black_queen" in tex):
				result += "bq "
		#Blank / unknown
			else:
				result += "_ "
	print("Result: ", result)