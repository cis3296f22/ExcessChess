extends "res://engine/piece/custom_piece.gd"
# Queen contains the queen chess piece logic.


var HorizontalMove = preload("res://engine/move/horizontal_move.gd")
var VerticalMove = preload("res://engine/move/vertical_move.gd")
var DiagonalPositiveMove = preload("res://engine/move/diagonal_positive_move.gd")
var DiagonalNegativeMove = preload("res://engine/move/diagonal_negative_move.gd")


func _init():
	# Add the default queen moves.
	add_move(HorizontalMove.new())
	add_move(VerticalMove.new())
	add_move(DiagonalPositiveMove.new())
	add_move(DiagonalNegativeMove.new())
