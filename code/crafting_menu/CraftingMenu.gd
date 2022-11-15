extends Control


var print_debug_msg = true

# Called when the node enters the scene tree for the first time.
func _ready():
	var group = $AvaliblePieces/GridContainer/Black_Pawn.get_button_group()
	group.connect("pressed",self,"piece_selected")
	
	$Board.connect("tile_clicked",self,"tile_placed")
	
#	$Board.highlight_square(2)
#	$Board.highlight_square(3)
#	$Board.highlight_square(12)
#	$Board.clear_highlights()


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
	save_board()
	

func save_board():
	if print_debug_msg: print( $Board.as_string() )
	#Todo: write this to a file
		
		
