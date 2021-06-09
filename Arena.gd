extends Node2D


export (PackedScene) var packed_client_agent
export (PackedScene) var packed_server_agent
export (PackedScene) var packed_player_controller


func _ready():
	var _err = Network.connect("joined_server", self, "_on_Network_joined_server")
	_err = Network.connect("peer_connected", self, "_on_Network_peer_connected")


func _on_Network_joined_server(id):
	var active_player = packed_client_agent.instance()
	var controller = packed_player_controller.instance()
	active_player.controller = controller
	active_player.add_child(controller)
	active_player.activate_camera()
	active_player.name = str(id)
	active_player.set_network_mode()
	add_child(active_player)


func _on_Network_peer_connected(id):
	# TODO: Different behavior for server
	var peer = packed_client_agent.instance()
	peer.controller = PeerController.new()
	peer.name = str(id)
	add_child(peer)
