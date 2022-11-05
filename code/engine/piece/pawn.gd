# Pawn represents the pawn chess piece logic.


# Given game state information, this function returns a list of potentially valid new positions.
# Arguments:
# pos: The original position. of the piece.
# piece: The piece's state information.
# game: The game's state information.
# Return:
#	Returns an array of positions.
func calc_moves(pos, piece, game):
	var positions = []
	var sgn = 1 if piece.team == game.Team[1] else -1
	var new_pos

	# Get forward movements.
	new_pos = pos + sgn * game.get("width")
	_add_move(positions, new_pos, game.get("max_pos"), game.pieces)
	if not piece.has_moved:
		_add_move(positions, new_pos + sgn * game.get("width"), game.get("max_pos"), game.pieces)
	# Get diagonal captures.
	_add_capture(positions, new_pos + 1, piece, game.pieces)
	_add_capture(positions, new_pos -1, piece, game.pieces)

	# TODO Implement en passant validation using prev_move.
	return positions
	pass


# Checks if a space is unoccupied, and if so, adds it to the list of positions.
# Arguments:
# positions: The list of positions.
# new_pos: The prospective position.
# max_pos: The maximum position.
# board_map: The map of board positions and chess pieces.
func _add_move(positions, new_pos, max_pos, pieces):
	if not pieces.has(new_pos) and new_pos >= 0 and new_pos <= max_pos:
		positions.append(new_pos)


# Checks if a space is occupied and can be captured, and if so, adds it to the
# list of positions.
# Arguments:
# positions: The list of positions.
# new_pos: The prospective position.
# piece: The state of the moving piece.
# board: The map of board positions and chess pieces.
func _add_capture(positions, new_pos, piece, pieces):
	if pieces.has(new_pos) and pieces[new_pos].team != piece.team:
		positions.append(new_pos)
