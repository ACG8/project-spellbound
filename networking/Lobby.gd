extends CanvasLayer


func _ready():
	var _err = Network.connect("finished_server_setup", self, "_on_Network_finished_server_setup")
	_err = Network.connect("joined_server", self, "_on_Network_joined_server")


func _on_Network_finished_server_setup():
	queue_free()


func _on_Network_joined_server(_id):
	queue_free()
