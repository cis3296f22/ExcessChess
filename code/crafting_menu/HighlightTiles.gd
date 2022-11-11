tool
extends GridContainer

#Todo: inherit sizes from board
export var DEFUALT_WIDTH = 8
export var DEFUALT_HEIGHT = 8

var contents = [] #.resize(DEFUALT_WIDTH*DEFUALT_HEIGHT)

var white_square = preload("res://assets/board/white_square.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	set_columns(DEFUALT_WIDTH)
	
	for _i in range(DEFUALT_HEIGHT):
		for _j in range(DEFUALT_WIDTH):
			var x = TextureRect.new()
			x.texture = white_square
			x.set_mouse_filter(Control.MOUSE_FILTER_IGNORE) #Allow clicks on the button below
			x.set_modulate(Color(1,1,0,0)) #Make the highlight transparent to begin with
			contents.append(x) #Save to list of children
			add_child(x) #And add it to scene tree

func highlight_square(child:int, color:Color = Color(1,1,0,0.5)):
	contents[child].set_modulate(color)
	
