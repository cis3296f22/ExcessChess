# PieceState stores information about one chess piece.


# Properties
var id
var team
var type
var has_moved


func _init(_id, _team, _type):
	id = _id
	team = _team
	type = _type
	has_moved = false
