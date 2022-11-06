extends "res://engine/piece/custom_piece.gd"
# King contains the king chess piece logic.


var KingBasicMove = preload("res://engine/move/king_basic_move.gd")


func _init():
	# Add the default king moves.
	add_move(KingBasicMove.new())

	# TODO Add kingside and queenside castling validation.
