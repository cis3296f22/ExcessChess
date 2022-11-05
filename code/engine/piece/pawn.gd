# Pawn represents the pawn chess piece logic.


# Given game state information, this function returns a list of potentially valid new positions.
# Arguments:
# pos: The original position. of the piece.
# piece: The piece's state information.
# gaem: The game's state information.
func calc_moves(pos, piece, game):
	var moves = []
	var sgn = 1 if piece.team == game.Team[1] else -1
	var new_pos

	# Get forward movements.
	new_pos = pos + sgn * game.get("width")
	_add_move(moves, new_pos, game.get("max_pos"), game.pieces)
	if not piece.has_moved:
		_add_move(moves, new_pos + sgn * game.get("width"), game.get("max_pos"), game.pieces)
	# Get diagonal captures.
	_add_capture(moves, new_pos + 1, piece, game.pieces)
	_add_capture(moves, new_pos -1, piece, game.pieces)

	# TODO Implement en passant validation using prev_move.
	return moves
	pass


# Checks if a space is unoccupied, and if so, adds it to the list of moves.
# Arguments:
# moves: The list of moves.
# new_pos: The prospective position.
# max_pos: The maximum position.
# board_map: The map of board positions and chess pieces.
func _add_move(moves, new_pos, max_pos, pieces):
	if not pieces.has(new_pos) and new_pos >= 0 and new_pos <= max_pos:
		moves.append(new_pos)


# Checks if a space is occupied and can be captured, and if so, adds it to the
# list of moves.
# Arguments:
# moves: The list of moves.
# new_pos: The prospective position.
# piece: The state of the moving piece.
# board: The map of board positions and chess pieces.
func _add_capture(moves, new_pos, piece, pieces):
	if pieces.has(new_pos) and pieces[new_pos].team != piece.team:
		moves.append(new_pos)
