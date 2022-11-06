extends "res://engine/piece/custom_piece.gd"
# Bishop contains the bishop chess piece logic.


var DiagonalPositiveMove = preload("res://engine/move/diagonal_positive_move.gd")
var DiagonalNegativeMove = preload("res://engine/move/diagonal_negative_move.gd")


func _init():
	# Add the default bishop moves.
	add_move(DiagonalPositiveMove.new())
	add_move(DiagonalNegativeMove.new())
