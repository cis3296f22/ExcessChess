# Stores information about the game state and configuration.


# Game Configuration
var Team = ["white", "black"]
var width: int
var height: int
var max_pos: int

# Game State
var pieces
# var history


func _init(width_new: int, height_new: int):
	width = width_new
	height = height_new
	max_pos = width * height - 1
