extends Button


var text_lable
var count = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	#In the scene tree, get the file from the path name
	text_lable = get_node("../Label")
	
	#connect the signal "pressed" to the function named "on_press" in this object
	connect("pressed",self,"_on_press")


#User-defined function we call when the button is presses
func _on_press():
	count += 1
	text_lable.text = "Button pressed " + str(count) + " times!"


