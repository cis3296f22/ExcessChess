tool

extends GridContainer


export var DEFUALT_WIDTH = 8
export var DEFUALT_HEIGHT = 8
var contents = [] #.resize(DEFUALT_WIDTH*DEFUALT_HEIGHT)

var green_square = preload("res://assets/board/green_square.png")
var bishop = load("res://black_bishop.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	set_columns(DEFUALT_WIDTH)
	
	
	for i in range(DEFUALT_HEIGHT):
		for j in range(DEFUALT_WIDTH):
			#var myRect = Rect2(Vector2(0,0), Vector2(100,100))
			
			var x = TextureRect.new()
			x.texture = green_square
			
			
			
			x.set_modulate(Color(1,1,1,0)) #Set alpha to 0, so it's invisible
			x.set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
#			x.set_id( (i*DEFUALT_WIDTH) + j)
#			x.texture_hover = green_square
			contents.append(x)
			add_child(x)

#			x.texture_pressed = black_square
#			x.texture_hover = green_square

func show_child(child:int):
	contents[child].set_modulate(Color(1,1,1,1))
	
#func child_pressed(bound):
#	print("Child ", bound, " Pressed!")
