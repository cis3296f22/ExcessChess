extends Node

#Autoload class for global variables and utility classes, such as point


#Textures. Potential addition: changing these via a function to a user-given texture set.
var white_pawn_tex = preload("res://assets/pieces/white_pawn.png")
var white_rook_tex = preload("res://assets/pieces/white_rook.png")
var white_knight_tex = preload("res://assets/pieces/white_knight.png")
var white_bishop_tex = preload("res://assets/pieces/white_bishop.png")
var white_king_tex = preload("res://assets/pieces/white_king.png")
var white_queen_tex = preload("res://assets/pieces/white_queen.png")

var black_pawn_tex = preload("res://assets/pieces/black_pawn.png")
var black_rook_tex = preload("res://assets/pieces/black_rook.png")
var black_knight_tex = preload("res://assets/pieces/black_knight.png")
var black_bishop_tex = preload("res://assets/pieces/black_bishop.png")
var black_king_tex = preload("res://assets/pieces/black_king.png")
var black_queen_tex = preload("res://assets/pieces/black_queen.png")





class point:# Declare member variables here. Examples:
	var x:int
	var y:int

	func _init(X:int = 0, Y:int = 0): #The constructor
		x = X
		y = Y

class array2:
	var items = []
	var rows
	var cols
	func _init(col, row):
		cols = col
		rows = row
		items.resize(row*col)
	
	func at(x,y):
	#If it's out of bounds, it will fail on array access, 
	#but print an error if it's a legal position accesed incorrectly (eg, at(0,6) on a 3x3 array)
		if !(x < cols && y < rows):
			push_error("Incorrect indexing") 
		return items[x + y*cols]
	
	func put(item,x,y):
		if !(x < cols && y < rows):
			push_error("Incorrect indexing")
		items[x + y*cols] = item	
	
	func valid_pos(x,y):
		return(x < cols && y < rows)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
