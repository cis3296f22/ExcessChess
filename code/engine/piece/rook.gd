# Rook represents the rook chess piece logic.


const linear = preload("res://engine/move/linear_move.gd")


# Given game state information, this function returns a list of potentially valid new positions.
# Arguments:
# pos: The original position. of the piece.
# piece: The piece's state information.
# game: The game's state information.
func calc_moves(pos, piece, game):
	var moves = []
	var start_rank = game.get("width") * pos / game.get("width")
	var start_file = pos % game.get("width")

	# Get rank movements.
	linear.add_moves(moves, piece.team, pos - 1, start_rank - 1, - 1, game.get("max_pos"), game.pieces)
	linear.add_moves(moves, piece.team, pos + 1, start_rank + game.get("width"), 1, game.get("max_pos"), game.pieces)
	# Get file movements.
	linear.add_moves(moves, piece.team, pos + game.get("width"), game.get("max_pos") + 1, game.get("width"), game.get("max_pos"), game.pieces)
	linear.add_moves(moves, piece.team, pos - game.get("width"), start_file - 1, -game.get("width"), game.get("max_pos"), game.pieces)

	return moves
