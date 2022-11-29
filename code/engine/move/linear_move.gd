# LinearMove contains the logic for a movement in an unobstructed straight line.

# Validates a line of spaces in one direction, and adds valid spaces to the list of positions.
# Arguments:
# positions: The array of positions.
# start: The first space to check.
# end: The space to stop at, but not check.
# step: The index length between spaces.
# team: The piece's team.
# game: The game state.
static func add_pos_linear(positions, start, end, step, team, game):
	# Check spaces in one direction from the origin.
	for new_pos in range(start, end, step):
		if not game.has(new_pos):
			# Add position if it is in bounds.
			if new_pos >= 0 and new_pos <= game.max_pos:
				positions.append(new_pos)
		else:
			# If the piece is on the opposing team, then add position.
			if game.state_from_cord(new_pos).team != team:
				positions.append(new_pos)
			# Exit loop because pieces block further movement.
			break
