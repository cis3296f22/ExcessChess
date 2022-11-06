# LinearMove contains the logic for a knight's movements.


# Movement vectors.
var movements = [[1, 2], [-1, 2]]
# Cardinal rotations
var rotations = [[1, 0, 0, 1], [0, -1, 1, 0], [-1, 0, 0, -1], [0, 1, -1, 0]]


# Properties
var name


func _init(name_):
	name = name_


# Validates squares for a knight's move and adds them to the list of positions.
# Arguments:
# positions: The array of positions.
# game: The game state information.
# pos: The original position of the piece.
# piece: The selected piece's state information.
func add_pos(positions, game, pos, _piece):
	for move in movements:
		for rot in rotations:
			var new_pos = (
					pos
					+ move[0] * rot[0]
					+ move[1] * rot[1]
					+ (move[0] * rot[2] + move[1] * rot[3]) * game.width
			)
			if (
					new_pos >= 0
					and new_pos <= game.max_pos
			):
				positions.append(new_pos)
