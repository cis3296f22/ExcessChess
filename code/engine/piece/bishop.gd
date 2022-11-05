# Bishop represents the bishop chess piece logic.


const linear = preload("res://engine/move/linear_move.gd")


# Given game state information, this function returns a list of potentially valid new positions.
# Arguments:
# pos: The original position. of the piece.
# piece: The piece's state information.
# game: The game's state information.
func calc_moves(pos, piece, game):
	var moves = []
	var start_file = pos % game.get("width")

	# Get movements.
	linear.add_moves(moves, piece.team, pos + game.get("width") + 1, pos + (game.get("width") - start_file - 1) * (game.get("width") + 1),
			game.get("width") + 1, game.get("max_pos"), game.pieces)
	linear.add_moves(moves, piece.team, pos + game.get("width") - 1, pos + (start_file) * (game.get("width") - 1),
			game.get("width") - 1, game.get("max_pos"), game.pieces)
	linear.add_moves(moves, piece.team, pos - game.get("width") - 1, pos + (start_file) * (-1 - game.get("width")),
			-1 - game.get("width"), game.get("max_pos"), game.pieces)
	linear.add_moves(moves, piece.team, pos - game.get("width") + 1, pos + (game.get("width") - start_file - 1) * (1 - game.get("width")),
			1 - game.get("width"), game.get("max_pos"), game.pieces)

	return moves
