extends Node2D


export (PackedScene) var packed_client_agent
export (PackedScene) var packed_player_controller
export (PackedScene) var packed_peer_controller


func _ready():
	var _err = Network.connect("joined_server", self, "_on_Network_joined_server")
	_err = Network.connect("peer_connected", self, "_on_Network_peer_connected")
	_err = Network.connect("finished_server_setup", self, "_on_Network_finished_server_setup")


func _on_Network_joined_server(id):
	var active_player: Node = packed_client_agent.instance()
	var controller = packed_player_controller.instance()
	active_player.controller = controller
	active_player.add_child(controller)
	active_player.activate_camera()
	active_player.name = str(id)
	active_player.set_network_master(id)
	add_child(active_player)


func _on_Network_peer_connected(id):
	var peer: Node = packed_client_agent.instance()
	var controller = packed_peer_controller.instance()
	peer.controller = controller
	peer.add_child(controller)
	peer.name = str(id)
	peer.set_network_master(id)
	add_child(peer)


func _on_Network_finished_server_setup():
	_on_Network_joined_server(get_tree().get_network_unique_id())
