# KingBasicMove contains the logic for a one-tile movement in eight directions.


# Cardinal directions
var directions = [[0, 1], [1,1], [1, 0], [1, -1],
		[0, -1], [-1, -1], [-1, 0], [-1, 1]]


# Properties
var name
var can_capture
var must_capture


func _init(name_ = "1-space 8-directions (king)", can_capture_ = true, must_capture_ = false):
	name = name_
	can_capture = can_capture_
	must_capture = must_capture_


# Validates a line of spaces and adds valid spaces to the list of positions.
# Arguments:
# positions: The array of positions.
# game: The game state information.
# pos: The original position of the piece.
# piece: The selected piece's state information.
func add_pos(positions, game, pos, _piece):
	var new_pos
	var pieces = game.pieces
	for dir in directions:
		new_pos = pos + dir[0] + dir[1] * game.width

		if (
			new_pos >= 0
			and new_pos <= game.max_pos
			and (
				(pieces.has(new_pos) and can_capture)
				or (not pieces.has(new_pos) and not must_capture)
			)
		):
			positions.append(new_pos)
