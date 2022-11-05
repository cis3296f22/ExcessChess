# CustomPiece stores custom chess piece logic.


var move_list = []


# Given game state information, this function returns a list of potentially valid new positions.
# Arguments:
# positions: 
# pos: The original position. of the piece.
# piece: The piece's state information.
# game: The game's state information.
# Return:
#	Returns an array of positions.
func calc_moves(pos, piece, game):
	var positions = []
	for move in move_list:
		move.add_pos(positions, pos, piece, game)
	return positions

# Adds a move to the move list.
# Return:
#	Returns true if successful.
func add_move(new_move):
	if (new_move.has_method("add_pos")
			and new_move.has_method("getName")
			and _find_move_name(new_move.getName() != -1)
	):
		move_list.append(new_move)
		return true
	return false

# Removes a move with a particular name from the move list.
# Return:
#	Returns the move if successful, else null.
func remove_move(name):
	var index = _find_move_name(name)
	if (index != -1):
		return move_list.pop_at(index)
	else:
		return null

# Returns an array of move names.
func get_move_names():
	var move_names = []
	for move in move_list:
		move_names.append(move.getName())
	return move_names

# Checks if a particular name exists in the move list.
# Return:
#	Returns its position if found, otherwise -1.
func _find_move_name(name):
	for i in move_list.size():
		if move_list[i].getName == name:
			return i
	return -1
