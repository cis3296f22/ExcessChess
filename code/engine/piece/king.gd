# King contains the king chess piece logic.


# Cardinal directions
var directions = [[0, 1], [1,1], [1, 0], [1, -1],
		[0, -1], [-1, -1], [-1, 0], [-1, 1]]


# Given game state information, this function returns a list of potentially valid new positions.
# Arguments:
# pos: The original position. of the piece.
# piece: The piece's state information.
# game: The game's state information.
# Return:
#	Returns an array of positions.
func calc_moves(pos, piece, game):
	var positions = []

	# Get basic movements.
	for dir in directions:
		var new_pos = pos + dir[0] + dir[1] * game.get("width")
		_add_move(positions, new_pos, piece.team, game.get("max_pos"), game.pieces)

	# TODO Implement castling validation.

	return positions


# Checks if a space can be moved into, and if so, adds it to the list.
# Arguments:
# positions: The array of positions to append to.
# new_pos: The prospective position.
# max_pos: The maximum board position.
# team: The piece's team.
# pieces: The map of board positions and chess pieces.
func _add_move(positions, new_pos, max_pos, team, pieces):
	if (
			new_pos >= 0
			and new_pos <= max_pos
			and (not pieces.has(new_pos) or pieces[new_pos].team != team)
	):
		positions.append(new_pos)
