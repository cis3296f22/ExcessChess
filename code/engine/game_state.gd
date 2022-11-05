# Stores information about the game configuration and state.


# Game Configuration
var Team = ["white", "black"]
var width: int
var height: int
var max_pos: int

# Game State
var pieces
# var history


func _init(_width: int, _height: int):
	width = _width
	height = _height
	max_pos = width * height - 1
	pieces = {}
