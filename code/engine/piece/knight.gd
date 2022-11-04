extends Piece
# Knight represents the knight chess piece.


var movements = [[1, 2], [-1, 2]]
# Cardinal rotations
var rotations = [[1, 0, 0, 1], [0, -1, 1, 0], [-1, 0, 0, -1], [0, 1, -1, 0]]


func _init(team_new, id_new).(team_new, Type.KNIGHT, id_new):
	pass


func calc_moves(orig_pos, max_pos, board_width, board_map, _prev_move):
	var moves = []
	for move in movements:
		for rot in rotations:
			var new_pos = (
					orig_pos
					+ move[0] * rot[0]
					+ move[1] * rot[1]
					+ (move[0] * rot[2] + move[1] * rot[3]) * board_width
			)
			if (
					new_pos >= 0
					and new_pos <= max_pos
					and (not board_map.has(new_pos) or board_map[new_pos].get("team") != team)
			):
				moves.append(new_pos)
	return moves
