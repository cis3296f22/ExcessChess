extends Piece
# Rook represents the rook chess piece.


func _init(team_new):
	team = team_new
	type = Type.ROOK
	hasMoved = false

func getMoves(orig_pos, max_pos, board_width, board_map, _prev_move):
	var moves = []
	var start_rank = board_width * orig_pos / board_width
	var start_file = orig_pos % board_width

	# Get rank movements.
	_reach(moves, orig_pos - 1, start_rank - 1, - 1, max_pos, board_map)
	_reach(moves, orig_pos + 1, start_rank + board_width, 1, max_pos, board_map)
	# Get file movements.
	_reach(moves, orig_pos + board_width, max_pos + 1, board_width, max_pos, board_map)
	_reach(moves, orig_pos - board_width, start_file - 1, -board_width, max_pos, board_map)

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