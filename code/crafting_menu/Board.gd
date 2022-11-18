tool #Allow it to work in editor
extends Control

#This class manages/echos the children

#Echo the signal from the buttons
signal tile_clicked(tile)

#Cont.
func _ready():
	$SquareSelector.connect("tile_clicked",self,"tile_selected")
#Cont.
func tile_selected(tile):
	emit_signal("tile_clicked",tile)

#Given a location and a texture, update the pice there
#Use null for no piece
func set_piece(tile, piece):
	$PieceDrawer.show_child(tile, piece)

#Get the board size and pieces as a string
func as_string():
	return $PieceDrawer.as_string()

#Replace the contents of the board using a string to specify piece layout
func from_string(string):
	$PieceDrawer.from_string(string)

#Set the higlight overlay on a certain tile. Default collor is a yellow.
#Use any color with the last value (the alpha) set to 0 to clear. For example, Color(0,0,0,0) is "Transparent black"
func highlight_square(child:int, color:Color = Color(1,1,0,0.75)):
	$HighlightTiles.highlight_square(child, color)


func clear_highlights():
	for i in $HighlightTiles.contents:
		i.set_modulate(Color(0,0,0,0))
	#TODO: Add a clear_highight function to remove all highlights

#TODO: add a fill_board function to take a list of textures and automatically apply them to the board. 



