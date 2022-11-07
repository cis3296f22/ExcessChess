extends "res://engine/move/linear_move.gd"
# HorizontalMove contains the logic for a move within a rank.


func _init(name_ = "left-and-right", can_capture_ = true, must_capture_ = false, max_length_= -1).(
		name_, can_capture_, must_capture_, max_length_
):
	pass


func add_pos(positions, game, pos, _piece):
	var start
	var end
	# Check spaces to the right.
	start = pos + 1
	end = game.width * (pos / game.width + 1)
	if start < end:
		add_pos_linear(positions, start, end, 1, game.max_pos, game.pieces)
	# Check spaces to the left.
	start = pos - 1
	end = game.width * (pos / game.width) - 1
	if start > end:
		add_pos_linear(positions, start, end, -1, game.max_pos, game.pieces)
