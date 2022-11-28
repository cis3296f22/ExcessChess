tool
extends GridContainer

#Todo: inherit sizes from board
var WIDTH = 8
var HEIGHT = 8

var contents = [] #.resize(WIDTH*HEIGHT)

var white_square = preload("res://assets/board/white_square.png")

# Called when the node enters the scene tree for the first time.
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
	contents = []
	
	for _i in range(HEIGHT):
		for _j in range(WIDTH):
			var x = TextureRect.new()
			x.texture = white_square
			x.set_mouse_filter(Control.MOUSE_FILTER_IGNORE) #Allow clicks on the button below
			x.set_modulate(Color(1,1,0,0)) #Make the highlight transparent to begin with
			contents.append(x) #Save to list of children
			add_child(x) #And add it to scene tree

func highlight_square(child:int, color:Color = Color(1,1,0,0.5)):
	contents[child].set_modulate(color)
	
