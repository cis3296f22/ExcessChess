extends Node

#Autoload class for global variables and utility classes, such as point


class point:# Declare member variables here. Examples:
	var x:int
	var y:int

	func _init(X:int = 0, Y:int = 0): #The constructor
		x = X
		y = Y

class array2:
	var items = []
	var rows
	var cols
	func _init(col, row):
		cols = col
		rows = row
		items.resize(row*col)
	
	func at(x,y):
	#If it's out of bounds, it will fail on array access, 
	#but print an error if it's a legal position accesed incorrectly (eg, at(0,6) on a 3x3 array)
		if !(x < cols && y < rows):
			push_error("Incorrect indexing") 
		return items[x + y*cols]
	
	func put(item,x,y):
		if !(x < cols && y < rows):
			push_error("Incorrect indexing")
		items[x + y*cols] = item	
	
	func valid_pos(x,y):
		return(x < cols && y < rows)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
