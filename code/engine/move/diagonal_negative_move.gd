extends "res://engine/move/linear_move.gd"
# DiagonalNegativeMove contains the logic for a move in the negative diagonal (up-right).


func _init(name_ = "diagonal SW-NE", can_capture_ = true, must_capture_ = false, max_length_= -1).(
		name_, can_capture_, must_capture_, max_length_
):
	pass


func add_pos(positions, game, pos, _piece):
	var start: int
	var end: int
	var file = pos % game.width
	var rank = pos / game.width
	# Check spaces down-left from origin.
	start = pos + game.width - 1
	end = pos + 1 + (game.width - 1) * round(min(file, game.height - rank - 1))
	if start < end:
		add_pos_linear(positions, start, end, game.width - 1, game.max_pos, game.pieces)
	# Check spaces up-right from origin.
	start = pos - game.width + 1
	end = pos - 1 - (game.width - 1) * round(min(game.width - file - 1, rank))
	if start > end:
		add_pos_linear(positions, start, end, 1 - game.width, game.max_pos, game.pieces)
