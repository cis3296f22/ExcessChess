# LinearMove contains the logic for a movement in an unobstructed straight line.


# Properties
var name
var can_capture
var must_capture
var max_length


func _init(name_, can_capture_, must_capture_, max_length_):
	name = name_
	can_capture = can_capture_
	must_capture = must_capture_
	max_length = max_length_


# Validates a line of spaces and adds valid spaces to the list of positions.
# Arguments:
# positions: The array of positions.
# game: The game state information.
# pos: The original position of the piece.
# piece: The selected piece's state information.
func add_pos(_positions, _game, _pos, _piece):
	pass


# Validates a line of spaces in one direction, and adds valid spaces to the list of positions.
# Arguments:
# positions: The array of positions.
# start: The first space to check.
# end: The space to stop at, but not check.
# step: The index length between spaces.
# max_pos: The maximum board position.
# pieces: The map of board positions and chess pieces.
func add_pos_linear(positions, start, end, step, max_pos, pieces):
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
