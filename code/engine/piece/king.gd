extends Piece
# King represents the king chess piece.


# Cardinal directions
var directions = [[0, 1], [1,1], [1, 0], [1, -1],
		[0, -1], [-1, -1], [-1, 0], [-1, 1]]


func _init(team_new, id_new).(team_new, Type.KING, id_new):
	pass


func calc_moves(orig_pos, max_pos, board_width, board_map, _prev_move):
	var moves = []

	# Get basic movements.
	for dir in directions:
		var new_pos = orig_pos + dir[0] + dir[1] * board_width
		if _is_move_valid(new_pos, max_pos, board_map):
			moves.append(new_pos)

	# TODO Implement castling validation.

	return moves


# Checks if a space can be moved into.
# Arguments:
# new_pos: The prospective position.
# max_pos: The maximum position.
# board_map: The map of board positions and chess pieces.
# Return:
#   True is the move is valid, else false.
func _is_move_valid(new_pos, max_pos, board_map):
	if (
			new_pos >= 0
			and new_pos <= max_pos
			and (not board_map.has(new_pos) or board_map[new_pos].get("team") != team)
	):
		return true
	else:
		return false
