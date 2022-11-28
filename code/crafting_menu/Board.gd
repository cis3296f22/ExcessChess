tool #Allow it to work in editor
extends Control

#This class manages/echos the children

var clickable = true
var new_game


#Echo the signal from the buttons
signal tile_clicked(tile)

#Cont.
func _ready():
	if get_tree().has_network_peer ():
		$HUD/MenuBox.visible = true
		$HUD/Remind.visible = true
		
	multiplayer_configs()	
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("server_disconnected", self, "announcement", ["opponent disconnected"])
	$SquareSelector.connect("tile_clicked",self,"tile_selected")
	

	_set_rect_size_from_tiles()
	
	connect("resized", self, "was_resized")
	was_resized() #Update based on initial conditions
	

func was_resized():
	yield(get_tree(),"idle_frame")
	var factors = rect_size / _get_rect_size_from_tiles()
	var scale_factor = min(factors.x, factors.y)
	rect_scale = Vector2(scale_factor, scale_factor)
#	print("Set rect scale to ", rect_size / _get_rect_size_from_tiles())

func _get_rect_size_from_tiles():
	var w = $SquareSelector.white_square.get_width()
	var h = $SquareSelector.white_square.get_height()
	var _size = Vector2(w*$SquareSelector.WIDTH,h*$SquareSelector.HEIGHT)
	return _size

func _set_rect_size_from_tiles():
	rect_min_size = _get_rect_size_from_tiles()


#Cont.
func tile_selected(tile):
	emit_signal("tile_clicked",tile)
	$HUD/Remind.visible = false
	#print("board emitting tile clicked")

func resize(width, height):
	$SquareSelector.resize(width,height)
	$HighlightTiles.resize(width,height)
	$PieceDrawer.resize(width,height)
	_set_rect_size_from_tiles()
	was_resized()

#Given a location and a texture, update the pice there
#Use null for no piece
func set_piece(tile, piece):
	$PieceDrawer.show_child(tile, piece)

#Get the board size and pieces as a string
func as_string():
	return $PieceDrawer.as_string()

#Replace the contents of the board using a string to specify piece layout
func from_string(string):
	$PieceDrawer.from_string(string)

#Set the higlight overlay on a certain tile. Default collor is a yellow.
#Use any color with the last value (the alpha) set to 0 to clear. For example, Color(0,0,0,0) is "Transparent black"
func highlight_square(child:int, color:Color = Color(1,1,0,0.75)):
	#print("board is highlighting square:", child, " color: ", color)
	$HighlightTiles.highlight_square(child, color)


func clear_highlights():
	for i in $HighlightTiles.contents:
		i.set_modulate(Color(0,0,0,0))
	#TODO: Add a clear_highight function to remove all highlights

#TODO: add a fill_board function to take a list of textures and automatically apply them to the board. 



func draw_offer():
	clickable = false
	$HUD/MenuBox.visible = false
	$HUD/DrawOffer.visible = true
	$HUD/Announcement.visible = true
	$HUD/Announcement/Announcement.text = 'Do You Accept a Draw?'

func game_over (message):
	clickable = false
	$HUD/MenuBox.visible = false
	$HUD/BackPanel.visible = false
	$HUD/Announcement/Announcement.text = message
	$HUD/Announcement.visible = true
	$HUD/EndGame.visible = true
	
func _on_Surrender_pressed():
	$HUD/Remind.visible = false
	game_over('You have surrendered')
	rpc( 'game_over', 'The oppenent has surrendered')

func _on_Draw_pressed():
	$HUD/Remind.visible = false
	clickable = false
	$HUD/MenuBox.visible = true
	rpc ('draw_offer')
	
func _on_Accept_pressed():
	$HUD/DrawOffer.visible = false
	game_over('You get a Draw')
	rpc( 'game_over', 'You have a DRAW')

func _on_Decline_pressed():
	$HUD/DrawOffer.visible = false
	$HUD/MenuBox.visible = true
	$HUD/Announcement.visible = false
	clickable = true
	rpc ('announcement', 'Your draw request has declined')
	
func announcement(text):
	if get_tree().has_network_peer ():
		var timer = Timer.new()
		$HUD/Announcement.visible = true
		$HUD/Announcement/Announcement.text = text
		clickable = false
		timer.wait_time = 2
		timer.one_shot = true
		add_child(timer)
		timer.start()
		
func _player_disconnected(_id):
	announcement ("opponent disconnected")



func reload_scene():
	get_tree().reload_current_scene()

func reload_client():
	rpc ('reload_scene')
	reload_scene()

func _on_Restart_pressed():
	if get_tree().has_network_peer ():
		if new_game:
			if get_tree().is_network_server():
				rpc ('reload_client')

			elif not get_tree().is_network_server():
				rpc ('reload_scene')
				reload_scene()

		else:
			$HUD/Announcement/Announcement.text = 'Re-start request sent'
			rset ('new_game', true)

func end_game ():
	if get_tree().has_network_peer ():
		get_tree().set_network_peer(null)
	get_tree().change_scene("res://crafting_menu/Menu.tscn")

func _on_Exit_pressed():
	end_game()


func _on_BackPanel_pressed():
	get_tree().change_scene("res://crafting_menu/Menu.tscn")
	
func multiplayer_configs ():
	rpc_config("game_over", 1)
	rpc_config("draw_offer", 1)
	rpc_config("announcement", 1)
	rpc_config("reload_scene", 1)
	rpc_config("reload_client", 1)
	
	rset_config("new_game", 1)
	rset_config("clickable", 1)







