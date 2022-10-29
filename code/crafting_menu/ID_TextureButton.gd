extends TextureButton


var ID = -1


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("pressed",get_parent(),"child_pressed",[ID])

func set_id(id:int):
	ID = id


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
