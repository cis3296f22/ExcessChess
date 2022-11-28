extends Control

const DEFAULT_PORT = 9010

var rng = RandomNumberGenerator.new()

onready var address = $LobbyPanel/Address
onready var port_forward_label = $PortForward

onready var status_ok = $TextPanel/StatusOk
onready var status_fail = $TextPanel/StatusFail
onready var text_panel = $TextPanel

onready var host_button = $VBoxContainer/Host
onready var join_button = $VBoxContainer/Join

var peer = null
var color_index

func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("connection_failed", self, "_connected_fail")
	
	rpc_config("change_to_game", 1)

	
func _player_connected(_id):
	change_to_game()

func change_to_game():
	get_tree().change_scene("res://Chess.tscn")
		

	
func _connected_fail():
	_set_status("Couldn't connect", false)

	get_tree().set_network_peer(null) 
	host_button.set_disabled(false)
	join_button.set_disabled(false)

func _set_status(text, isok):
	if isok:
		status_ok.set_text(text)
		status_fail.set_text("")
	else:
		status_ok.set_text("")
		status_fail.set_text(text)

func _on_Join_pressed():
	$LobbyPanel.visible = true
	address.grab_focus()

func _on_Host_pressed():
	$LobbyPanel.visible = false
	text_panel.visible = true
	port_forward_label.visible = true
	
	peer = NetworkedMultiplayerENet.new()

	var err = peer.create_server(DEFAULT_PORT, 1)
	if err != OK:
		_set_status("Can't Create Because Address Has Been Used.",false)
		return
		
	get_tree().set_network_peer(peer)
	_set_status("Waiting For Another Player......", true)

func _on_OkButton_pressed():
	text_panel.visible = true
	
	var ip = address.get_text()
	if not ip.is_valid_ip_address():
		_set_status("Invaild IP, Please Re-enter", false)
		return

	peer = NetworkedMultiplayerENet.new()
	
	
	peer.create_client(ip, DEFAULT_PORT)
	get_tree().set_network_peer(peer)
	_set_status("Connecting...", true)

func _on_Address_text_entered(_new_text):
	_on_OkButton_pressed ()
	

func _on_Local_pressed():
	get_tree().set_network_peer(null)
	get_tree().change_scene("res://Chess.tscn")

func _on_Back_pressed():
	get_tree().change_scene("res://scenes/TitleScreen.tscn")
