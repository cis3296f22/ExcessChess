tool
extends GridContainer


export var DEFUALT_WIDTH = 8
export var DEFUALT_HEIGHT = 8
var contents = [].resize(DEFUALT_WIDTH*DEFUALT_HEIGHT)

var white_square = preload("res://assets/board/white_square.png")
var black_square = preload("res://assets/board/black_square.png")
var green_square = preload("res://assets/board/green_square.png")
var bishop = preload("res://black_bishop.png")

var ID_TextureButton = preload("res://crafting_menu/ID_TextureButton.tscn")
var pieceFolder = "res://assets/blue and pink chess pieces/pieces/"
var pieceStrings = ["pawn", "rook", "knight", "bishop","queen", "king"]
var sideStrings = ["white_", "black_"]
var pieces_on_board = [1,2,3,4,5,3,2,1,0,0,0,0]
var sides_on_board =  [1,1,1,1,1,1,1,1,1,1,1,1]
var piece_textures = []


var myBishopCoord = []
var selected_tile

# Called when the node enters the scene tree for the first time.
func _ready():
	piece_textures.append([])
	piece_textures.append([])
	for piece in range(0,pieceStrings.size()):
		for side in range(0,2):
			print("doing side ",side)
			var string = pieceFolder + sideStrings[side] + pieceStrings[piece]+".png"
			var texture = load(string)
			piece_textures[side].append(texture)
	print(piece_textures)
	
	set_columns(DEFUALT_WIDTH)
	
	for i in range(DEFUALT_HEIGHT):
		for j in range(DEFUALT_WIDTH):
			var x = ID_TextureButton.instance()
			x.set_id( (i*DEFUALT_WIDTH) + j)
			x.texture_hover = green_square

			if (i%2) == 0: #First, third, etc row- start with white
				if(j%2) == 0:
					x.texture_normal = white_square
				else:
					x.texture_normal = black_square
			else: #2nd, 4th, etc row
				if(j%2) == 0:
					x.texture_normal = black_square
				else:
					x.texture_normal = white_square
			var rect = Rect2(Vector2(64*j - (48-64)/2,64*i - (96-64)), Vector2(48,96))
			draw_texture_rect(black_square, rect, true)
			myBishopCoord.append(rect)
			
			x.texture_normal = null
			add_child(x)

#			x.texture_pressed = black_square
#			x.texture_hover = green_square

func _draw():
	var children = get_children()
	for child in children:
		var i = child.ID % DEFUALT_WIDTH
		var j = child.ID / DEFUALT_WIDTH
		var index = i*DEFUALT_WIDTH + j
		var rect_tile = Rect2(Vector2(64*j,64*i), Vector2(64,64))
		var rect_piece = Rect2(Vector2(64*j - (48-64)/2,64*i - (96-64)), Vector2(48,96))
		if (i%2 + j%2) %2 == 0:
			draw_texture_rect(white_square, rect_tile, true)
		else:
			draw_texture_rect(black_square, rect_tile, true)
		
		if(index < pieces_on_board.size()):
			#var pieceString = pieceFolder + sideStrings[sides_on_board[index]] + pieceStrings[pieces_on_board[index]]+".png"
			#pieceString = "res://assets/blue and pink chess pieces/pieces/black_pawn.png"
			#print("printing: "+pieceString)
			var piece_image = piece_textures[sides_on_board[index]][pieces_on_board[index]]
			draw_texture_rect(piece_image, rect_piece, false)
			
			
		#draw_texture_rect(bishop, rect, false)
	
	#for rect in myBishopCoord:
	#	draw_texture_rect(bishop, rect, false)

func reDraw(selected_tile: int):
	
	var children = get_children()
	for child in children:
		var i = child.ID % DEFUALT_WIDTH
		var j = child.ID / DEFUALT_WIDTH
		if selected_tile == child.ID:
			child.texture_normal = green_square
		else:
			if (i%2 + j%2) %2 == 0:
				child.texture_normal = white_square
			else:
				child.texture_normal = black_square
				
func drawPieces():
	pass
		
	
	
	


func child_pressed(bound):
	selected_tile = bound
	#reDraw(bound)
	print("Child ", bound, " Pressed!")
	
	#$"../PieceDrawer".show_child(bound)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
