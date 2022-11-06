# ForwardMove contains the logic for a pawn's basic forward-rank move, which cannot capture.


# Properties
var name
var can_capture
var must_capture


func _init(name_ = "forward-1 (pawn)", can_capture_ = false, must_capture_ = false):
	name = name_
	can_capture = can_capture_
	must_capture = must_capture_

# Checks the square that is forward one square, relative to the piece's team.
# Arguments:
# positions: The array of positions.
# game: The game state information.
# pos: The original position of the piece.
# piece: The selected piece's state information.
func add_pos(positions, game, pos, piece):
	var pieces = game.pieces
	var new_pos
	# Use piece's team to decide forward-rank direction.
	new_pos = pos + game.width * (1 if piece.team == game.Team[1] else -1)
	if (
			new_pos >= 0
			and new_pos <= game.max_pos
			and (
					(pieces.has(new_pos) and can_capture)
					or (not pieces.has(new_pos) and not must_capture)
			)
	):
		positions.append(new_pos)
