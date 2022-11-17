extends "res://engine/piece/custom_piece.gd"
# Rook stores the rook chess piece logic.
var name = "rook"

var HMove = preload("res://engine/move/horizontal_move.gd")
var VMove = preload("res://engine/move/vertical_move.gd")


func _init():
	# Add the default rook moves.
	add_move(HMove.new("horizontal"))
	add_move(VMove.new("vertical"))
