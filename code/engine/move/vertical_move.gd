# VerticalMove contains the logic for a move within a file.


const linear = preload("res://engine/move/linear_move.gd")


# Properties
var name


func _init(name_):
	name = name_


# Validates a line of spaces and adds valid spaces to the list of positions.
# Arguments:
# positions: The array of positions.
# game: The game state information.
# pos: The original position of the piece.
# piece: The selected piece's state information.
func add_pos(positions, game, pos, piece):
	var start
	var end
	# Check spaces below.
	start = pos + game.width
	end = game.max_pos + 1
	if start < end:
		linear.add_pos_linear(positions, start, end, game.width,
				game.max_pos, piece.team, game.pieces)
	# Check spaces above.
	start = pos - game.width
	end = pos % game.width - 1
	if start > end:
		linear.add_pos_linear(positions, start, end, -game.width,
				game.max_pos, piece.team, game.pieces)
