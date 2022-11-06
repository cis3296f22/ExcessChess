# LinearMove contains the logic for a movement in an unobstructed straight line.


# Validates a line of spaces in one direction, and adds valid spaces to the list of positions.
# Arguments:
# positions: The array of positions.
# start: The first space to check.
# end: The space to stop at, but not check.
# step: The index length between spaces.
# max_pos: The maximum board position.
# max_length: The maximum length of the movement. -1 := no maximum length.
# can_capture: Flag for whether or not the move can capture.
# must_capture: Flag for whether or not the move must capture.
# pieces: The map of board positions and chess pieces.
static func add_pos_linear(positions, start, end, step, max_pos,
		max_length, can_capture, must_capture, pieces):
	# Check spaces in one direction from the origin.
	var length = max_length
	for new_pos in range(start, end, step):
		if not pieces.has(new_pos) and not must_capture:
			# Add position if it is inbounds.
			if new_pos >= 0 and new_pos <= max_pos:
				positions.append(new_pos)
		elif pieces.has(new_pos) and can_capture:
			# Add position of an occupying piece.
			positions.append(new_pos)
			# Exit loop because pieces block further movement.
			break
		length -= 1
		if length == 0:
			# Exit loop if maximum travel distance is reached.
			break
