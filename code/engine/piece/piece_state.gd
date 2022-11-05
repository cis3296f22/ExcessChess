# Stores information about one chess piece logic.


# Properties
var id
var team
var type
var has_moved


func _init(id_new, team_new, type_new):
	id = id_new
	team = team_new
	type = type_new
	has_moved = false