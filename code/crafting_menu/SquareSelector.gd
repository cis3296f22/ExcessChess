tool
extends GridContainer

signal tile_clicked(tile_id)

export var DEFUALT_WIDTH = 8
export var DEFUALT_HEIGHT = 8

var white_square = preload("res://assets/board/white_square.png")
var black_square = preload("res://assets/board/black_square.png")
var green_square = preload("res://assets/board/green_square.png")

var ID_TextureButton = preload("res://crafting_menu/ID_TextureButton.tscn")


func _ready():
	
	set_columns(DEFUALT_WIDTH)
	
	for i in range(DEFUALT_HEIGHT):
		for j in range(DEFUALT_WIDTH):
			var x = ID_TextureButton.instance()
			x.set_id( (i*DEFUALT_WIDTH) + j)
			x.texture_hover = green_square

			if (i%2) == 0: #First, third, etc row- start with white
				if(j%2) == 0:
					x.texture_normal = white_square
				else:
					x.texture_normal = black_square
			else: #2nd, 4th, etc row
				if(j%2) == 0:
					x.texture_normal = black_square
				else:
					x.texture_normal = white_square
			add_child(x)



func child_pressed(child_id):
	multiplayer_configs ()
#	print("Child ", child_id, " Pressed!")
	#print("emitting signal child clicked")
	rpc("synmultiplayer", child_id)
	emit_signal("tile_clicked", child_id)
	rpc("synmultiplayer", child_id)
	
#	$"../PieceDrawer".show_child(child_id, null)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func multiplayer_configs ():
	rpc_config("synmultiplayer", 1)
	rpc_config("child_pressed", 1)
	
	rset_config("child_id", 1)

func synmultiplayer(child_id):
	emit_signal("tile_clicked", child_id)
