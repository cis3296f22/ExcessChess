extends Node2D
const Chess = preload("res://chess.gd")
var chess = Chess.new()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func clicked_tile(tile_clicked: int):
	chess.tile_clicked(tile_clicked)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
