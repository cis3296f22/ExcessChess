extends Control


var print_debug_msg = true

# Called when the node enters the scene tree for the first time.
func _ready():
	var group = $AvaliblePieces/GridContainer/Black_Pawn.get_button_group()
	group.connect("pressed",self,"piece_selected")
	
	$Board.connect("tile_clicked",self,"tile_placed")
	
	#Load/save board
	$NameInput/LoadButton.connect("pressed",self,"load_board")
	
	#save board
	$NameInput/SaveButton.connect("pressed",self,"save_board")

#	$Board.highlight_square(2)
#	$Board.highlight_square(3)
#	$Board.highlight_square(12)
#	$Board.clear_highlights()


func save_board():
	var path = $NameInput.get_text()
	
	if(path == ""): #Todo: give user warning (not in terminal)
		print("Name not given!")
		return
	var file = File.new()
	file.open("user://"+path, file.WRITE)
	file.store_string($Board.as_string())
	file.close()


func load_board():
	#Get the provided name
	var path = "user://" + $NameInput.get_text()
	var file = File.new()
	
	if(file.file_exists(path)):
		#Proceed with loading
		print("File ", path," exists!")
		file.open(path, file.READ)
		$Board.from_string(file.get_as_text())
		file.close()
	else:
		#Todo: display user warning
		print("File does not exist, loading default...")
		$Board.from_string("8 8 _ black_pawn _ _ black_pawn _ _ _ _ _ _ black_pawn _ _ _ _ _ _ _ _ _ _ _ _ _ _ white_pawn white_pawn _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ white_queen white_queen")
		


var selected_texture = null
#Update the selection of the piece to place
func piece_selected(button):
	print(button, "Was selected")
	
	#Save the selection's texture
	if(button.name == "Empty"):
		selected_texture = null
	else:
		selected_texture = button.texture_normal 
#	$PiecePlacer/PieceDrawer.show_child(11, tex)


func tile_placed(tile):
	print("Tile ", tile, " selected")
#	$Board/PieceDrawer.show_child(tile, selected_texture)
	$Board.set_piece(tile, selected_texture)
#	print($Board.as_string())
