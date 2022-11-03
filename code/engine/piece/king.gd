extends Piece
# King represents the king chess piece.


# Cardinal directions
var directions = [[0, 1], [1,1], [1, 0], [1, -1],
		[0, -1], [-1, -1], [-1, 0], [-1, 1]]


func _init(team_new):
	team = team_new
	type = Type.KING
	has_moved = false


func calc_moves(orig_pos, max_pos, board_width, board_map, _prev_move):
	var moves = []

	# Get basic movements.
	for dir in directions:
		var position = orig_pos + dir[0] + dir[1] * board_width
		if _is_move_valid(position, max_pos, board_map):
			moves.append(position)

	# TODO Implement castling validation.

	return moves


# Checks if a space can be moved into.
# Arguments:
# position: The prospective position.
# max_pos: The maximum position.
# board_map: The map of board positions and chess pieces.
# Return:
#   True is the move is valid, else false.
func _is_move_valid(position, max_pos, board_map):
	if (
			position >= 0
			and position <= max_pos
			and (not board_map.has(position) or board_map[position].team != team)
	):
		return true
	else:
		return false
