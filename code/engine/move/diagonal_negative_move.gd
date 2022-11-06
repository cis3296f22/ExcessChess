# DiagonalNegativeMove contains the logic for a move in the negative diagonal (up-right).


const linear = preload("res://engine/move/linear_move.gd")


# Properties
var name
var max_length


func _init(name_, max_length_=-1):
	name = name_
	max_length = max_length_

# Validates a line of spaces and adds valid spaces to the list of positions.
# Arguments:
# positions: The array of positions.
# game: The game state information.
# pos: The original position of the piece.
# piece: The selected piece's state information.
func add_pos(positions, game, pos, _piece):
	var start: int
	var end: int
	var file = pos % game.width
	var rank = pos / game.width
	# Check spaces down-left from origin.
	start = pos + game.width - 1
	end = pos + 1 + (game.width - 1) * round(min(file, game.height - rank - 1))
	if start < end:
		linear.add_pos_linear(positions, start, end, game.width - 1,
				game.max_pos, max_length, game.pieces)
	# Check spaces up-right from origin.
	start = pos - game.width + 1
	end = pos - 1 - (game.width - 1) * round(min(game.width - file - 1, rank))
	if start > end:
		linear.add_pos_linear(positions, start, end, 1 - game.width,
				game.max_pos, max_length, game.pieces)
