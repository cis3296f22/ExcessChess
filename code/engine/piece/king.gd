# King represents the king chess piece logic.


# Cardinal directions
var directions = [[0, 1], [1,1], [1, 0], [1, -1],
		[0, -1], [-1, -1], [-1, 0], [-1, 1]]


# Given game state information, this function returns a list of potentially valid new positions.
# Arguments:
# pos: The original position. of the piece.
# piece: The piece's state information.
# game: The game's state information.
func calc_moves(pos, piece, game):
	var moves = []

	# Get basic movements.
	for dir in directions:
		var new_pos = pos + dir[0] + dir[1] * game.get("width")
		_add_move(moves, new_pos, piece.team, game.get("max_pos"), game.pieces)

	# TODO Implement castling validation.

	return moves


# Checks if a space can be moved into, and if so, adds it to the list.
# Arguments:
# new_pos: The prospective position.
# max_pos: The maximum board position.
# team: The piece's team.
# pieces: The map of board positions and chess pieces.
func _add_move(moves, new_pos, max_pos, team, pieces):
	if (
			new_pos >= 0
			and new_pos <= max_pos
			and (not pieces.has(new_pos) or pieces[new_pos].team != team)
	):
		moves.append(new_pos)
