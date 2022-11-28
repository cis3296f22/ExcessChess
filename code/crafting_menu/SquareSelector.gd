tool
extends GridContainer

signal tile_clicked(tile_id)

var WIDTH = 8
var HEIGHT = 8

var white_square = preload("res://assets/board/white_square.png")
var black_square = preload("res://assets/board/black_square.png")
var green_square = preload("res://assets/board/green_square.png")

var ID_TextureButton = preload("res://crafting_menu/ID_TextureButton.tscn")


func _ready():
	_setup()

func resize(width, height):
	WIDTH = width
	HEIGHT = height
	_setup()

func _setup():
	set_columns(WIDTH)

	
	#Throw out any existing children
	for n in get_children():
		n.queue_free()
	
	
	for i in range(HEIGHT):
		for j in range(WIDTH):
			var x = ID_TextureButton.instance()
			x.set_id( (i*WIDTH) + j)
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
#	print("Child ", child_id, " Pressed!")
	emit_signal("tile_clicked", child_id)
#	$"../PieceDrawer".show_child(child_id, null)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
