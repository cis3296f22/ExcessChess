# Pawn contains the pawn chess piece logic.
var name = "pawn"
var passeant_move_list = []
var passeant_attack_list = []

# Given game state information, this function returns a list of potentially valid new positions.
# Arguments:
# pos: The original position. of the piece.
# piece: The piece's state information.
# game: The game's state information.
# Return:
#	Returns an array of positions.
func calc_moves(pos, piece, game):
	passeant_move_list = []
	passeant_attack_list = []
	var positions = []
	var sgn = 1 if piece.team == game.Team[1] else -1
	var new_pos
	var can_move_forward: bool

	# Get forward movements.
	new_pos = pos + sgn * game.get("width")
	can_move_forward = _add_move(positions, new_pos, game.get("max_pos"), game)
	if not piece.has_moved and can_move_forward:
		_add_move(positions, new_pos + sgn * game.get("width"), game.get("max_pos"), game)
	# Get diagonal captures.
	_add_capture(positions, new_pos + 1, piece, game)
	_add_capture(positions, new_pos -1, piece, game)
	#new_pos is 2 blocks forward
	_add_passeant_capture(positions, new_pos + 1, pos + 1, piece, game)
	_add_passeant_capture(positions, new_pos - 1, pos - 1, piece, game)
	
	# TODO Implement en passant validation using prev_move.
	return positions
	pass


# Checks if a space is unoccupied, and if so, adds it to the list of positions.
# Arguments:
# positions: The list of positions.
# new_pos: The prospective position.
# max_pos: The maximum position.
# board_map: The map of board positions and chess pieces.
# Returns:
# Returns true if the addition was successful.
func _add_move(positions, new_pos, max_pos, game):
	if game.state_from_cord(new_pos) == null and new_pos >= 0 and new_pos <= max_pos:
		positions.append(new_pos)
		return true
	return false


# Checks if a space is occupied and can be captured, and if so, adds it to the
# list of positions.
# Arguments:
# positions: The list of positions.
# new_pos: The prospective position.
# piece: The state of the moving piece.
# board: The map of board positions and chess pieces.
func _add_capture(positions, new_pos, piece, game):
	if game.state_from_cord(new_pos) != null and game.state_from_cord(new_pos).team != piece.team:
		positions.append(new_pos)
		
func _add_passeant_capture(positions, new_pos, attack_pos, piece, game):
	if game.state_from_cord(attack_pos) != null and game.state_from_cord(attack_pos).team != piece.team:
		if game.state_from_cord(attack_pos).has_just_done_passeant:
			positions.append(new_pos)
			passeant_move_list.append(new_pos)
			passeant_attack_list.append(attack_pos)
			var attacked_piece = game.state_from_cord(attack_pos)
			
