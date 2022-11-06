# ForwardDiagonalMove contains the logic for a pawn's basic forward-diagonal
# moves, which must capture.


# Properties
var name
var can_capture
var must_capture


func _init(name_ = "forward-diagonal-1 (pawn)", can_capture_ = true, must_capture_ = true):
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
	var base_pos
	var new_pos
	# Use piece's team to decide forward-rank direction.
	base_pos = pos + game.width * (1 if piece.team == game.Team[1] else -1)
	for i in range(-1, 2, 2):
		new_pos = base_pos + i 
		if (
				new_pos >= 0
				and new_pos <= game.max_pos
				and (
						(pieces.has(new_pos) and can_capture)
						or (not pieces.has(new_pos) and not must_capture)
				)
		):
			positions.append(new_pos)
