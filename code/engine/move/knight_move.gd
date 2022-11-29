# LinearMove contains the logic for a knight's movements.


# Movement vectors.
var movements = [[1, 2], [-1, 2]]
# Cardinal rotations
var rotations = [[1, 0, 0, 1], [0, -1, 1, 0], [-1, 0, 0, -1], [0, 1, -1, 0]]


# Properties
var name


func _init(name_ = "L-shaped jump (knight)"):
	name = name_


# Validates squares for a knight's move and adds them to the list of positions.
# Arguments:
# positions: The array of positions.
# pos: The original position of the piece.
# piece: The selected piece's state information.
# game: The game state information.
func add_pos(positions, pos, piece, game):
	for move in movements:
		for rot in rotations:
			# Calculate position deltas.
			var delta_x = move[0] * rot[0] + move[1] * rot[2]
			var delta_y = move[0] * rot[1] + move[1] * rot[3]
			# Check if the movement is within width and height constraints.
			if (
					(pos % game.width) + delta_x >= 0
					and (pos % game.width) + delta_x < game.width
					and (pos / game.width) + delta_y >= 0
					and (pos / game.width) + delta_y < game.height
			):
				# Calculate the new position.
				var new_pos = (
						pos
						+ delta_x
						+ delta_y * game.width
				)
				if (
						new_pos >= 0
						and new_pos <= game.max_pos
						and (not game.has(new_pos)
								or game.state_from_cord(new_pos).team != piece.team)
				):
					positions.append(new_pos)