# ForwardDoubleMove contains the logic for a pawn's two-space forward-rank move,
# which must be its first move, and cannot capture.


# Properties
var name
var can_capture
var must_capture
var first_move


func _init(name_ = "forward-2 (pawn)", can_capture_ = false, must_capture_ = false, first_move_ = true):
	name = name_
	can_capture = can_capture_
	must_capture = must_capture_
	first_move = first_move_

# Checks the two squares rank-forward from the piece, relative to its team.
# Arguments:
# positions: The array of positions.
# game: The game state information.
# pos: The original position of the piece.
# piece: The selected piece's state information.
func add_pos(positions, game, pos, piece):
	var pieces = game.pieces
	var new_pos
	var delta
	# Use piece's team to decide forward-rank direction.
	delta = game.width * (1 if piece.team == game.Team[1] else -1)
	new_pos = pos + 2 * delta
	if (
			new_pos >= 0
			and new_pos <= game.max_pos
			and not pieces.has(new_pos - delta)
			and (not piece.has_moved or not first_move)
			and (
					(pieces.has(new_pos) and can_capture)
					or (not pieces.has(new_pos) and not must_capture)
			)
	):
		positions.append(new_pos)
