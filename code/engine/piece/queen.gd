# Queen represents the queen chess piece logic.


const linear = preload("res://engine/move/linear_move.gd")


# Given game state information, this function returns a list of potentially valid new positions.
# Arguments:
# pos: The original position. of the piece.
# piece: The piece's state information.
# game: The game's state information.
# Return:
#	Returns an array of positions.
func calc_moves(pos, piece, game):
	var positions = []
	var start_rank = game.width * pos / game.width
	var start_file = pos % game.width

	# Get rank movements.
	linear.add_moves(positions, piece.team, pos - 1, start_rank - 1, - 1, game.max_pos, game.pieces)
	linear.add_moves(positions, piece.team, pos + 1, start_rank + game.width, 1, game.max_pos, game.pieces)

	# Get file movements.
	linear.add_moves(positions, piece.team, pos + game.width, game.max_pos + 1, game.width, game.max_pos, game.pieces)
	linear.add_moves(positions, piece.team, pos - game.width, start_file - 1, -game.width, game.max_pos, game.pieces)

	# Get diagonal movements.
	linear.add_moves(positions, piece.team, pos + game.width + 1, pos + (game.width - start_file - 1) * (game.width + 1),
			game.width + 1, game.max_pos, game.pieces)
	linear.add_moves(positions, piece.team, pos + game.width - 1, pos + (start_file) * (game.width - 1),
			game.width - 1, game.max_pos, game.pieces)
	linear.add_moves(positions, piece.team, pos - game.width - 1, pos + (start_file) * (-1 - game.width),
			-1 - game.width, game.max_pos, game.pieces)
	linear.add_moves(positions, piece.team, pos - game.width + 1, pos + (game.width - start_file - 1) * (1 - game.width),
			1 - game.width, game.max_pos, game.pieces)

	return positions
