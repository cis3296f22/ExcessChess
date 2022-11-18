tool #Allow it to work in editor
extends Control

signal tile_clicked(tile)

#This node just manages and delegates from the children

#Echo the signals from the buttons
func _ready():
	$SquareSelector.connect("tile_clicked",self,"tile_selected")
#cont.
func tile_selected(tile):
	emit_signal("tile_clicked",tile)

#Set a pice to a specific texture
func set_piece(tile, piece):
	$PieceDrawer.show_child(tile, piece)

#Get the pieces and board size as a string
func as_string():
	return $PieceDrawer.as_string()


func highlight_square(child:int, color:Color = Color(1,1,0,0.75)):
	$HighlightTiles.highlight_square(child, color)
