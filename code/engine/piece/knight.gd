extends "res://engine/piece/custom_piece.gd"
# Knight stores the knight chess piece logic.


var KnightMove = preload("res://engine/move/knight_move.gd")
var name = "knight"


func _init():
	# Add the default knight moves.
	add_move(KnightMove.new())
