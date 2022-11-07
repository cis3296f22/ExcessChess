extends "res://engine/move/linear_move.gd"
# VerticalMove contains the logic for a move within a file.


func _init(name_ = "up-and-down", can_capture_ = true, must_capture_ = false, max_length_= -1).(
		name_, can_capture_, must_capture_, max_length_
):
	pass


func add_pos(positions, game, pos, _piece):
	var start
	var end
	# Check spaces below.
	start = pos + game.width
	end = game.max_pos + 1
	if start < end:
		add_pos_linear(positions, start, end, game.width, game.max_pos, game.pieces)
	# Check spaces above.
	start = pos - game.width
	end = pos % game.width - 1
	if start > end:
		add_pos_linear(positions, start, end, -game.width, game.max_pos, game.pieces)
