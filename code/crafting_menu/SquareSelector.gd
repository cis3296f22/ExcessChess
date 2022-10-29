tool
extends GridContainer


export var DEFUALT_WIDTH = 8
export var DEFUALT_HEIGHT = 8
var contents = [].resize(DEFUALT_WIDTH*DEFUALT_HEIGHT)

var white_square = preload("res://assets/board/white_square.png")
var black_square = preload("res://assets/board/black_square.png")
var green_square = preload("res://assets/board/green_square.png")

var ID_TextureButton = preload("res://crafting_menu/ID_TextureButton.tscn")

# Called when the node enters the scene tree for the first time.
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

#			x.texture_pressed = black_square
#			x.texture_hover = green_square


func child_pressed(bound):
	print("Child ", bound, " Pressed!")
	$"../PieceDrawer".show_child(bound)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
