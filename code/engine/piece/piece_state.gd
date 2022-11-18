# PieceState stores information about one chess piece.
var root = "res://assets/pieces/"

# Properties
var id
var team
var type
var has_moved
var team_and_type
var texture


func _init(_id, _team, _type):
	id = _id
	team = _team
	type = _type
	has_moved = false
	var piece_path = team + "_" + type.name
	var path = root + piece_path + ".png"
	print("loading: ", path)
	texture = load(path)
	

	
