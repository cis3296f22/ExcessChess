
extends Node

const custom_piece = preload("res://engine/piece/custom_piece.gd")
const bishop_class = preload("res://engine/piece/bishop.gd")
const king_class = preload("res://engine/piece/king.gd")
const knight_class = preload("res://engine/piece/knight.gd")
const pawn_class = preload("res://engine/piece/pawn.gd")
const queen_class = preload("res://engine/piece/queen.gd")
const rook_class = preload("res://engine/piece/rook.gd")
const piece_state_class = preload("res://engine/piece/piece_state.gd")
const Game_state = preload("res://engine/game_state.gd")
var game_state = Game_state.new(8, 8)
var bishop = bishop_class.new()
var king = king_class.new()
var knight = knight_class.new()
var pawn = pawn_class.new()
var queen = queen_class.new()
var rook = rook_class.new()
var initial_pieces_top = [
	rook, knight, bishop, king, queen, bishop, knight, rook,
	pawn, pawn, pawn, pawn, pawn, pawn, pawn, pawn]
var initial_pieces_bottom = [
	pawn, pawn, pawn, pawn, pawn, pawn, pawn, pawn,
	rook, knight, bishop, king, queen, bishop, knight, rook]
var piece_state_array = []
var piece_cord_array = []
var has_init = false
var board
var board_width
var board_height

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func from_string(initial_pieces, initial_teams, string):
	
	#split the string by whitespace. See:
	# https://github.com/godotengine/godot/issues/29554#issuecomment-500126883
	var r = RegEx.new()
	r.compile("\\S+") # negated whitespace character class
	var count = -2 #So forst peice will be 0
	var w
	var h
	for m in r.search_all(string):
		var token = m.get_string()
		
		if(count == -2): #width
			count += 1
			w = int(token)
			if(w < 1):
				w=1 #TODO: raise error
			continue
		if(count == -1): #height
			count += 1
			h = int(token)
			if(h < 1):
				h=1 #TODO: raise error
			#get_parent().resize(w,h)
			continue #TODO: resize/validate based on these values.
		
		if token == "_":
			initial_pieces.append(null)
			initial_teams.append(null)
			#show_child(count,null)
		elif token == "white_pawn":
			initial_pieces.append(initial_pieces_top[8])
			initial_teams.append("white")
			#show_child(count, Util.white_pawn_tex)
		elif token == "white_rook":
			initial_pieces.append(initial_pieces_top[0])
			initial_teams.append("white")
			#show_child(count, Util.white_rook_tex)
		elif token == "white_knight":
			initial_pieces.append(initial_pieces_top[1])
			initial_teams.append("white")
			#show_child(count, Util.white_knight_tex)
		elif token == "white_bishop":
			initial_pieces.append(initial_pieces_top[2])
			initial_teams.append("white")
			#show_child(count, Util.white_bishop_tex)
		elif token == "white_king":
			initial_pieces.append(initial_pieces_top[3])
			initial_teams.append("white")
			#show_child(count, Util.white_king_tex)
		elif token == "white_queen":
			initial_pieces.append(initial_pieces_top[4])
			initial_teams.append("white")
			#show_child(count, Util.white_queen_tex)
	#Black pieces
		elif token == "black_pawn":
			initial_pieces.append(initial_pieces_top[8])
			initial_teams.append("black")
			#show_child(count, Util.black_pawn_tex)
		elif token == "black_rook":
			initial_pieces.append(initial_pieces_top[0])
			initial_teams.append("black")
			#show_child(count, Util.black_rook_tex)
		elif token == "black_knight":
			initial_pieces.append(initial_pieces_top[1])
			initial_teams.append("black")
			#show_child(count, Util.black_knight_tex)
		elif token == "black_bishop":
			initial_pieces.append(initial_pieces_top[2])
			initial_teams.append("black")
			#show_child(count, Util.black_bishop_tex)
		elif token == "black_king":
			initial_pieces.append(initial_pieces_top[3])
			initial_teams.append("black")
			#show_child(count, Util.black_king_tex)
		elif token == "black_queen":
			initial_pieces.append(initial_pieces_top[4])
			initial_teams.append("black")
			#show_child(count, Util.black_queen_tex)
	#unknown
		else:
			initial_pieces.append(null)
			initial_teams.append(null)
			#show_child(count, null)
		
		count += 1
	#End loop
	board_width = w
	board_height = h
	board.resize(w, h)
	game_state = Game_state.new(w, h)
	

func setup_setup_default_pieces(initial_pieces, initial_teams):
	for i in range(0,16):
		#print(i, initial_pieces_top[i].name)
		initial_pieces.append(initial_pieces_top[i])
		initial_teams.append("black")
	for i in range(0,32):
		initial_pieces.append(null)
		initial_teams.append(null)
	for i in range(0,16):
		initial_pieces.append(initial_pieces_bottom[i])
		initial_teams.append("white")
	board_width = 8
	board_height = 8

func _init(_board, string):
	board = _board
	board.connect("tile_clicked", self, "tile_clicked")
	var initial_pieces = []
	var initial_teams = []
	if string == null:
		setup_setup_default_pieces(initial_pieces, initial_teams)
	else:
		from_string(initial_pieces, initial_teams, string)
	
	var id = 0
	print("number of tiles:",initial_pieces.size())
	for i in range(0, initial_pieces.size()):
		if(initial_pieces[i] == null):
			continue
		var state = piece_state_class.new(id, initial_teams[i], initial_pieces[i])
		piece_state_array.append(state)
		piece_cord_array.append(i)
		id = id+1
	for i in range(0, piece_state_array.size()):
		game_state.add(piece_state_array[i], piece_cord_array[i])
	print("hi")
	var children = get_children()
	for child in children:
		board = child
		#print(board)
		
	for i in range(0, game_state.pieces_state.size()):
		var state = game_state.pieces_state[i]
		var cord = game_state.pieces_cord[i]
		print(state.texture.get_width())
		board.set_piece(cord, state.texture)
	
	
		
# Called when the node enters the scene tree for the first time.

func _ready():
	pass

var tile_highlighted
var highlights
var possible_passeant_highlighted = []
var possible_passeant_attacked_piece = []
var white_turn = true
func tile_clicked(tile: int):#, state_array, cord_array, highlight_array
	print("clicked: ",tile)
	#print("chess got click")
	var moving_team
	if(white_turn):
		moving_team = "white"
	else:
		moving_team = "black"
	#if no piece has been chosen yet, do highlight
	if(tile_highlighted == null):
		highlights = []
		possible_passeant_highlighted = []
		possible_passeant_attacked_piece = []
		do_highlight(tile, moving_team)
	else:
		#if a piece has been chosen, and we selected a correct tile, do the move
		if highlights.has(tile):
			if(possible_passeant_highlighted.has(tile)):
				var index = possible_passeant_highlighted.find(tile, 0)
				game_state.passeant_move(tile_highlighted, tile, possible_passeant_attacked_piece[index])
				if(white_turn):
					white_turn = false
				else:
					white_turn = true
			else:
				move_piece(tile_highlighted, tile)
			tile_highlighted = null
			highlights = []
			possible_passeant_highlighted = []
			possible_passeant_attacked_piece = []
		#if we selected something that wasn't highlighted, try to highlight again
		else:
			possible_passeant_highlighted = []
			possible_passeant_attacked_piece = []
			do_highlight(tile, moving_team)
			
	check_for_promotion()
	#game info stored in game_state
	piece_cord_array = game_state.pieces_cord
	piece_state_array = game_state.pieces_state
	
	#this is sending the data to the drawer
	for i  in range(0, board_width*board_height):
		board.set_piece(i, null)
	
	for i in range(0, piece_cord_array.size()):
		var cord = (piece_cord_array[i])
		var state = (piece_state_array[i])
		board.set_piece(cord, state.texture)
		
		#cord_array.append(piece_cord_array[i])
		#state_array.append(piece_state_array[i])
	board.clear_highlights()
	for i in range(0, highlights.size()):
		#print("highlighting square: ", highlights[i])
		board.highlight_square(highlights[i])

func check_for_promotion():
	var state_temp = piece_state_class.new(1, "white", pawn)
	for i in range(0, board_width):
		if game_state.has_specific_type(i, state_temp):
			game_state.state_from_cord(i).change_type(queen)
			break
	state_temp = piece_state_class.new(1, "black", pawn)
	for i in range(board_width*(board_height - 1), board_width*board_height):
		if game_state.has_specific_type(i, state_temp):
			game_state.state_from_cord(i).change_type(queen)
			break

#returns whether a tile is highlighted
func highlighted(tile: int, highlights):
	for pos in highlights:
		if(pos == tile):
			return true
	return false

func do_highlight(tile: int, moving_team):
	if game_state.state_from_cord(tile) == null:
		return
	if(game_state.state_from_cord(tile).team == moving_team):
		tile_highlighted = tile
		highlights = get_moves_of_piece(tile, game_state, true)
		if highlights.size() > 0:
			remove_moves_that_kill_king(highlights, tile_highlighted)
	else:
		tile_highlighted = null
		highlights = []

func move_piece(tile: int, new_tile: int):
	game_state.move(tile, new_tile)
	if(white_turn):
		white_turn = false
	else:
		white_turn = true
	
func get_moves_of_piece(tile: int, game, allow_special_move):
	var state = game.state_from_cord(tile)
	if state == null:
		return []
	var moves = state.type.calc_moves(tile, state, game)
	
	if state.type.name == "pawn" && allow_special_move:
		if state.type.passeant_move_list.size() != 0:
			possible_passeant_highlighted = state.type.passeant_move_list
			possible_passeant_attacked_piece = state.type.passeant_attack_list
	#print(moves)
	return moves

#checks all the moves highlighted, does the move, then checks whether the king is a target.
#if the king is a target, it is an invalid move, and we remove it.
func remove_moves_that_kill_king(highlights, tile_highlighted):
	var team = game_state.state_from_cord(tile_highlighted).team
	var my_king_tile
	var list_moves_to_remove = []
	#find the tile the friendly king is one
	for i in range(0, game_state.pieces_state.size()):
		if(game_state.pieces_state[i].type == king and game_state.pieces_state[i].team == team):
			my_king_tile = game_state.pieces_cord[i]
	var temp_game
	#copy the game, and do each available move
	for i in range(0, highlights.size()):
		temp_game = game_state.copy(Game_state.new(board_width, board_height))
		temp_game.move(tile_highlighted, highlights[i])
		#if the move allows the enemy to kill the king, remove the move
		if(move_kills_king(temp_game, my_king_tile, team)):
			list_moves_to_remove.append(highlights[i])
	#here we actually remove the move from our list
	for i in range(0, list_moves_to_remove.size()):
		highlights.erase(list_moves_to_remove[i])
	
func move_kills_king(temp_game, my_king_tile, team):
		for j in range(0, temp_game.pieces_state.size()):
			if(temp_game.pieces_state[j].team == team):
				continue
			var moves = get_moves_of_piece(temp_game.pieces_cord[j], temp_game, false)
			if moves.has(my_king_tile):
				return true
		return false



func dostuff():
	pass
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
