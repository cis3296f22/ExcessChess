extends "res://engine/piece/custom_piece.gd"
# Queen contains the queen chess piece logic.
var name = "queen"

var HMove = preload("res://engine/move/horizontal_move.gd")
var VMove = preload("res://engine/move/vertical_move.gd")
var DPosMove = preload("res://engine/move/diagonal_positive_move.gd")
var DNegMove = preload("res://engine/move/diagonal_negative_move.gd")


func _init():
	# Add the default queen moves.
	add_move(HMove.new("horizontal"))
	add_move(VMove.new("vertical"))
	add_move(DPosMove.new("diagonal NW-SE"))
	add_move(DNegMove.new("diagonal SW-NE"))
