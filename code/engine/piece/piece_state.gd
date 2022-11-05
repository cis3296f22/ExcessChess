# Stores information about one chess piece logic.


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