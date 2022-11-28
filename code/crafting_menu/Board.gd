tool #Allow it to work in editor
extends Control

#This class manages/echos the children

#Echo the signal from the buttons
signal tile_clicked(tile)

#Cont.
func _ready():
	$SquareSelector.connect("tile_clicked",self,"tile_selected")

	_set_rect_size_from_tiles()
	
	connect("resized", self, "was_resized")
	was_resized() #Update based on initial conditions
	

func was_resized():
	yield(get_tree(),"idle_frame")
	var factors = rect_size / _get_rect_size_from_tiles()
	var scale_factor = min(factors.x, factors.y)
	rect_scale = Vector2(scale_factor, scale_factor)
#	print("Set rect scale to ", rect_size / _get_rect_size_from_tiles())

func _get_rect_size_from_tiles():
	var w = $SquareSelector.white_square.get_width()
	var h = $SquareSelector.white_square.get_height()
	var _size = Vector2(w*$SquareSelector.WIDTH,h*$SquareSelector.HEIGHT)
	return _size

func _set_rect_size_from_tiles():
	rect_min_size = _get_rect_size_from_tiles()


#Cont.
func tile_selected(tile):
	emit_signal("tile_clicked",tile)
	#print("board emitting tile clicked")

func resize(width, height):
	$SquareSelector.resize(width,height)
	$HighlightTiles.resize(width,height)
	$PieceDrawer.resize(width,height)
	_set_rect_size_from_tiles()
	was_resized()

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
	#print("board is highlighting square:", child, " color: ", color)
	$HighlightTiles.highlight_square(child, color)


func clear_highlights():
	for i in $HighlightTiles.contents:
		i.set_modulate(Color(0,0,0,0))
	#TODO: Add a clear_highight function to remove all highlights

#TODO: add a fill_board function to take a list of textures and automatically apply them to the board. 



