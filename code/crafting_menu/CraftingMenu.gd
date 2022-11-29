extends Container


var print_debug_msg = true

onready var Board = $MarginContainer/Board
onready var LoadButton = $VBoxContainer/HBoxContainer/LoadButton
onready var SaveButton = $VBoxContainer/HBoxContainer/SaveButton
onready var NameInput = $VBoxContainer/NameInput


# Called when the node enters the scene tree for the first time.
func _ready():
	var group = $VBoxContainer/AvaliblePieces/GridContainer/Black_Pawn.get_button_group()
	group.connect("pressed",self,"piece_selected")
	
	Board.connect("tile_clicked",self,"tile_placed")
	
	#Load/save board
	LoadButton.connect("pressed",self,"load_board")
	
	#save board
	SaveButton.connect("pressed",self,"save_board")
	
	#Handle Resizing
	$VBoxContainer/WidthBox/Decrease.connect("pressed",self,"decrease_width")
	$VBoxContainer/WidthBox/Increase.connect("pressed",self,"increase_width")
	$VBoxContainer/HeightBox/Decrease.connect("pressed",self,"decrease_height")
	$VBoxContainer/HeightBox/Increase.connect("pressed",self,"increase_height")
	

var width = 8
var height = 8
var min_width = 3
var min_height = 3
onready var width_label = $VBoxContainer/WidthBox/Label
onready var height_label = $VBoxContainer/HeightBox/Label

func decrease_width():
	width -= 1
	width = max(width,min_width)
	Board.resize(width,height)
	width_label.text = " Width: " + str(width) + " "
func increase_width():
	width += 1
	Board.resize(width,height)
	width_label.text = " Width: " + str(width) + " "
func decrease_height():
	height -= 1
	height = max(height,min_height)
	Board.resize(width,height)
	height_label.text = " Height: " + str(height) + " "
func increase_height():
	height += 1
	Board.resize(width,height)
	height_label.text = " Height: " + str(height) + " "

func save_board():
	var path = NameInput.get_text()
	
	if(path == ""): #Todo: give user warning (not in terminal)
		print("Name not given!")
		return
	var file = File.new()
	file.open("user://"+path, file.WRITE)
	file.store_string(Board.as_string())
	file.close()


func load_board():
	#Get the provided name
	var path = "user://" + NameInput.get_text()
	var file = File.new()
	
	if(file.file_exists(path)):
		#Proceed with loading
		print("File ", path," exists!")
		file.open(path, file.READ)
		Board.from_string(file.get_as_text())
		file.close()
	else:
		#Todo: display user warning
		print("File does not exist, loading default...")
		Board.from_string("8 8 _ black_pawn _ _ black_pawn _ _ _ _ _ _ black_pawn _ _ _ _ _ _ _ _ _ _ _ _ _ _ white_pawn white_pawn _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ white_queen white_queen")
		


var selected_texture = null
var old_piece = null
#Update the selection of the piece to place
func piece_selected(button):
#	print(button, "Was selected")
	
	#Highlight it to indicate selecton
	if(old_piece): old_piece.self_modulate = Color(1,1,1,1)
	button.self_modulate = (Color.yellow + Color.darkslategray)/2
	old_piece = button
	
	#Save the selection's texture
	if(button.name == "Empty"):
		selected_texture = null
	else:
		selected_texture = button.texture_normal 
#	$PiecePlacer/PieceDrawer.show_child(11, tex)


func tile_placed(tile):
	print("Tile ", tile, " selected")
#	$Board/PieceDrawer.show_child(tile, selected_texture)
	Board.set_piece(tile, selected_texture)
#	print($Board.as_string())
