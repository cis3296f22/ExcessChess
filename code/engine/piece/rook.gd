extends Piece
# Rook represents the rook chess piece.


const linear = preload("res://engine/move/linear_move.gd")


func _init(team_new, id_new).(team_new, Type.ROOK, id_new):
	pass


func calc_moves(orig_pos, max_pos, board_width, board_map, _prev_move):
	var moves = []
	var start_rank = board_width * orig_pos / board_width
	var start_file = orig_pos % board_width

	# Get rank movements.
	linear.add_moves(moves, team, orig_pos - 1, start_rank - 1, - 1, max_pos, board_map)
	linear.add_moves(moves, team, orig_pos + 1, start_rank + board_width, 1, max_pos, board_map)
	# Get file movements.
	linear.add_moves(moves, team, orig_pos + board_width, max_pos + 1, board_width, max_pos, board_map)
	linear.add_moves(moves, team, orig_pos - board_width, start_file - 1, -board_width, max_pos, board_map)

	return moves
