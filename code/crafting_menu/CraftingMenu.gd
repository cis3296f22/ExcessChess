extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var group = $AvaliblePieces/GridContainer/Black_Pawn.get_button_group()
	group.connect("pressed",self,"piece_selected")
	
	$PiecePlacer/SquareSelector.connect("tile_clicked",self,"tile_placed")
#	/Black_Bishop.get_groups()[0].connect("pressed",self,"piece_selected")

var selected_texture = null
func piece_selected(button):
	print(button, "Was selected")
	selected_texture = button.texture_normal #Save the selection's texture
#	$PiecePlacer/PieceDrawer.show_child(11, tex)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func tile_placed(tile):
	print("Tile ", tile, " selected")
	$PiecePlacer/PieceDrawer.show_child(tile, selected_texture)
	save_board()
	

func save_board():
	$PiecePlacer/PieceDrawer.as_string()
#	pass #Will call to_string on piecedrawer and put it in a file
		
		
