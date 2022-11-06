extends "res://engine/piece/custom_piece.gd"
# Pawn contains the pawn chess piece logic.


var ForwardMove = preload("res://engine/move/forward_move.gd")
var ForwardDiagonalMove = preload("res://engine/move/forward_diagonal_move.gd")
var ForwardDoubleMove = preload("res://engine/move/forward_double_move.gd")


func _init():
	# Add the default pawn moves.
	add_move(ForwardMove.new())
	add_move(ForwardDiagonalMove.new())
	add_move(ForwardDoubleMove.new())
