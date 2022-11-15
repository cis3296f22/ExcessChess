extends "res://engine/piece/custom_piece.gd"
# Bishop contains the bishop chess piece logic.


var DPosMove = preload("res://engine/move/diagonal_positive_move.gd")
var DNegMove = preload("res://engine/move/diagonal_negative_move.gd")
var name = "bishop"

func _init():
	# Add the default bishop moves.
	add_move(DPosMove.new("diagonal NW-SE"))
	add_move(DNegMove.new("diagonal SW-NE"))
