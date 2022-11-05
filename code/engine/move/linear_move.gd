# Checks the board from edge to edge for spaces to move through, including capturing an enemy king.
# Arguments:
# moves: The list of moves.
# team: The selected piece's team.
# start: The initial position to check.
# end: The final position, which is not checked.
# step: The distance between positions checked.
# max_pos: The maximum position.
# pieces: The map of board positions and chess pieces.
static func add_moves(moves, team, start, end, step, max_pos, pieces):
	for pos in range(start, end, step):
		if not pieces.has(pos):
			if pos >= 0 and pos <= max_pos:
				moves.append(pos)
		else:
			# If the piece can be captured, then add move.
			if pieces[pos].team != team:
				moves.append(pos)
			# Exit loop because pieces block further movement.
			break
