extends Node


const PORT = 27015
const MAX_PLAYERS = 8


signal finished_server_setup
signal joined_server(id)
signal peer_disconnected(id)
signal peer_connected(id)


func _on_Host_pressed():
	create_server()


func _on_Connect_pressed(address: String):
	pass


func create_server():
	var _err = get_tree().connect("network_peer_connected", self, "_on_peer_connected")
	_err = get_tree().connect("network_peer_disconnected", self, "_on_peer_disconnected")
	var network = NetworkedMultiplayerENet.new()
	network.create_server(PORT, MAX_PLAYERS - 1)
	get_tree().set_network_peer(network)
	emit_signal("finished_server_setup")


func join_server(ip):
	var _err = get_tree().connect("network_peer_connected", self, "_on_peer_connected")
	_err = get_tree().connect("network_peer_disconnected", self, "_on_peer_disconnected")
	_err = get_tree().connect("connected_to_server", self, "_on_connected_to_server")
	_err = get_tree().connect("connection_failed", self, "_on_connection_failed")
	_err = get_tree().connect("server_disconnected", self, "_on_server_disconnected")
	var network = NetworkedMultiplayerENet.new()
	network.create_client(ip, PORT)
	get_tree().set_network_peer(network)


func _on_ConnectButton_pressed(ip):
	join_server(ip)


func _on_HostButton_pressed():
	create_server()


func _on_peer_connected(id):
	print("peer connected: ", str(id))
	emit_signal("peer_connected", id)


func _on_peer_disconnected(id):
	print("peer disconnected: ", str(id))
	emit_signal("peer_disconnected", id)


func _on_connected_to_server():
	var id = get_tree().get_network_unique_id()
	print("Connected! ID = ", str(id))
	emit_signal("joined_server", id)


func _on_connection_failed():
	get_tree().set_network_peer(null)
	print("Connection failed")


func _on_server_disconnected():
	var _err = get_tree().reload_current_scene()
