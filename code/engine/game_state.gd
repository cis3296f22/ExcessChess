# Stores information about the game configuration and state.
const piece_state = preload("res://engine/piece/piece_state.gd")

# Game Configuration
var Team = ["white", "black"]
var width: int
var height: int
var max_pos: int



# Game State
var pieces_state
var pieces_cord
# var history
func state_from_cord(cord: int):
	for i in range(0, pieces_state.size()):
		if(pieces_cord[i] == cord):
			return pieces_state[i]
	return null
	
func index_from_cord(cord: int):
	for i in range(0, pieces_state.size()):
		if(pieces_cord[i] == cord):
			return i
	return null

func copy(new_game):
	new_game.pieces_state = []
	new_game.pieces_cord = []
	for i in range(0, pieces_cord.size()):
		new_game.pieces_state.append(piece_state.new(pieces_state[i].id,pieces_state[i].team ,pieces_state[i].type))
		new_game.pieces_cord.append(pieces_cord[i])
	return new_game
	

	
func add(state, cord):
	pieces_state.append(state)
	pieces_cord.append(cord)

func has(cord: int):
	if state_from_cord(cord) == null:
		return false
	return true

func remove(index):
	pieces_cord.remove(index)
	pieces_state.remove(index)

func move(current_tile, new_tile):
	var kill = index_from_cord(new_tile)
	if(kill != null):
		remove(kill)
	var index = index_from_cord(current_tile)
	#print("index: ",index, "old_tile: ", pieces_cord[index])

	pieces_cord[index] = new_tile
	pieces_state[index].has_moved = true
	


func _init(_width: int, _height: int):
	width = _width
	height = _height
	max_pos = width * height - 1
	pieces_state = []
	pieces_cord = []
