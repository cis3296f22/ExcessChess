# Knight represents the knight chess piece logic.


var movements = [[1, 2], [-1, 2]]
# Cardinal rotations
var rotations = [[1, 0, 0, 1], [0, -1, 1, 0], [-1, 0, 0, -1], [0, 1, -1, 0]]


# Given game state information, this function returns a list of potentially valid new positions.
# Arguments:
# pos: The original position. of the piece.
# piece: The piece's state information.
# game: The game's state information.
func calc_moves(pos, piece, game):
	var moves = []
	var pieces = game.pieces
	for move in movements:
		for rot in rotations:
			var new_pos = (
					pos
					+ move[0] * rot[0]
					+ move[1] * rot[1]
					+ (move[0] * rot[2] + move[1] * rot[3]) * game.get("width")
			)
			if (
					new_pos >= 0
					and new_pos <= game.get("max_pos")
					and (not pieces.has(new_pos) or pieces[new_pos].team != piece.team)
			):
				moves.append(new_pos)
	return moves
