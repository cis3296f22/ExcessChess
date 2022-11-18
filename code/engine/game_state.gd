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

func has_specific_type(cord: int, state_test):
	var boolean
	if has(cord) == true:
		var state = state_from_cord(cord)
		if(state.type.name == "pawn"):
			boolean = true
		#if(boolean):
			#print("testing pawn at cord: ", cord, "state:", state.team)
		if state.type == state_test.type && state.team == state_test.team:
			#print("test is true")
			return true
	#print("test is false")
	return false

func remove(index):
	pieces_cord.remove(index)
	pieces_state.remove(index)

func move(current_tile, new_tile):
	var kill = index_from_cord(new_tile)
	if(kill != null):
		remove(kill)
	var index = index_from_cord(current_tile)
	if (new_tile - current_tile == width * 2 || current_tile - new_tile == 2 * width) && pieces_state[index].type.name == "pawn":
		pieces_state[index].has_just_done_passeant = true
	else:
		pieces_state[index].has_just_done_passeant = false
	pieces_cord[index] = new_tile
	pieces_state[index].has_moved = true
	
func passeant_move(current_tile, new_tile, attacked_piece):
	var index = index_from_cord(current_tile)
	pieces_cord[index] = new_tile
	pieces_state[index].has_moved = true
	var kill = index_from_cord(attacked_piece)
	remove(kill)
	

func _init(_width: int, _height: int):
	width = _width
	height = _height
	max_pos = width * height - 1
	pieces_state = []
	pieces_cord = []
