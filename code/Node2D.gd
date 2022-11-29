extends Node2D
const Chess = preload("res://chess.gd")
var board
var chess
var custom_board_name = null
var path_custom_board = "user://default_board"


func load_board_string():
	#Get the provided name
	var path = path_custom_board
	var file = File.new()
	
	if(file.file_exists(path)):
		#Proceed with loading
		print("File ", path," exists!")
		file.open(path, file.READ)
		return file.get_as_text()
		file.close()
	else:
		#Todo: display user warning
		print("File does not exist, loading default...")
		#return ("8 8 _ black_pawn _ _ black_pawn _ _ _ _ _ _ black_pawn _ _ _ _ _ _ _ _ _ _ _ _ _ _ white_pawn white_pawn _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ white_queen white_queen")
		return null
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print("created a chess scene")
	board = $Board
	print("custom: ", custom_board_name)
	if custom_board_name == null:
		start_custom_board(custom_board_name)
	else:
		start_regular_game()
	#chess = Chess.new(board, null)
	
func start_regular_game():
	print("starting regular_game in node")
	#board = $Board
	chess = Chess.new(board, null)
	
func start_custom_board(board_name):
	board = $Board
	chess = Chess.new(board, load_board_string())
	
	
	pass # Replace with function body.

func clicked_tile(tile_clicked: int):
	chess.tile_clicked(tile_clicked)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
