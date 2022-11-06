extends "res://engine/piece/custom_piece.gd"
# Rook stores the rook chess piece logic.


var HorizontalMove = preload("res://engine/move/horizontal_move.gd")
var VerticalMove = preload("res://engine/move/vertical_move.gd")


func _init():
	# Add the default rook moves.
	add_move(HorizontalMove.new())
	add_move(VerticalMove.new())
