extends Piece
# Bishop represents the bishop chess piece.


func _init(team_new):
	team = team_new
	type = Type.BISHOP
	hasMoved = false

func getMoves(orig_pos, max_pos, board_width, board_map, _prev_move):
	var moves = []
	var start_file = orig_pos % board_width

	# Get movements.
	_reach(moves, orig_pos + board_width + 1, orig_pos + (board_width - start_file - 1) * (board_width + 1),
			board_width + 1, max_pos, board_map)
	_reach(moves, orig_pos + board_width - 1, orig_pos + (start_file) * (board_width - 1),
			board_width - 1, max_pos, board_map)
	_reach(moves, orig_pos - board_width - 1, orig_pos + (start_file) * (-1 - board_width),
			-1 - board_width, max_pos, board_map)
	_reach(moves, orig_pos - board_width + 1, orig_pos + (board_width - start_file - 1) * (1 - board_width),
			1 - board_width, max_pos, board_map)

	return moves


func _reach(moves, start, end, step, max_pos, board_map):
	for pos in range(start, end, step):
		if not board_map.has(pos):
			if pos >= 0 and pos <= max_pos:
				moves.append(pos)
		else:
			# If the piece can be captured, then update reach.
			if board_map[pos].team != team and board_map[pos].type != Type.KING:
				moves.append(pos)
			# Exit loop because pieces block further movement.
			break