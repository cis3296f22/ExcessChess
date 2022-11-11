tool
extends GridContainer


export var DEFUALT_WIDTH = 8
export var DEFUALT_HEIGHT = 8
var contents = [].resize(DEFUALT_WIDTH*DEFUALT_HEIGHT)

const Chess = preload("res://chess.gd")
var chess = Chess.new()
const custom_piece = preload("res://engine/piece/custom_piece.gd")

var white_square = preload("res://assets/board/white_square.png")
var black_square = preload("res://assets/board/black_square.png")
var green_square = preload("res://assets/board/green_square.png")

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
		if search_highlight(index):
			draw_texture_rect(green_square, rect_tile, true)
		else:
			if (i%2 + j%2) %2 == 0:
				draw_texture_rect(white_square, rect_tile, true)
			else:
				draw_texture_rect(black_square, rect_tile, true)
		
		var piece_index = search_index_from_cord(index)
		
		#print("cord:", index, "i: ", piece_index)
		if(piece_index != -1):
			var state = piece_state_array[piece_index]
			var type_number = get_index_from_piece_name(state.type.name)
			var side_number = get_index_from_side_name(state.team)
			var piece_image = piece_textures[side_number][type_number]
			draw_texture_rect(piece_image, rect_piece, false)
			#print(state.type.name, " ",state.team, " ", type_number, " ", side_number)
		
			
		#if(index < pieces_on_board.size()):
			#var piece_image = piece_textures[sides_on_board[index]][pieces_on_board[index]]
			#draw_texture_rect(piece_image, rect_piece, false)
	print("finished drawing**********")

func get_index_from_piece_name(name: String):
	if(name == "pawn"):
		return 0
	if name == "rook":
		return 1
	if name == "knight":
		return 2
	if name == "bishop":
		return 3
	if name == "queen":
		return 4
	if name == "king":
		return 5
		
func get_index_from_side_name(name: String):
	if name == "white":
		return 0
	if name == "black":
		return 1

func search_index_from_cord(cord: int):
	for i in range(0, piece_cord_array.size()):
		if(piece_cord_array[i] == cord):
			return i
	return -1
	
func search_highlight(cord: int):
	for i in range(0, highlight_array.size()):
		if(highlight_array[i] == cord):
			return true
	return false
		#draw_texture_rect(bishop, rect, false)
	
	#for rect in myBishopCoord:
	#	draw_texture_rect(bishop, rect, false)
var piece_state_array = []
var piece_cord_array = []
var highlight_array = []
	
func reDraw(piece_state, piece_cord):
	piece_state_array = piece_state
	piece_cord_array = piece_cord
	_draw()
				
func drawPieces():
	pass
		
	
	
	

func child_pressed(bound):
	piece_state_array = []
	piece_cord_array = []
	highlight_array = []
	selected_tile = bound
	chess.tile_clicked(bound, piece_state_array, piece_cord_array, highlight_array)
	update()
	#_draw()
	
	#reDraw(bound)
	print("Child ", bound, " Pressed!")
	
	#$"../PieceDrawer".show_child(bound)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
