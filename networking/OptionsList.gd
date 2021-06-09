extends VBoxContainer


export var ip := "localhost"
export var background_server := false


func _ready():
	var _err = $HostButton.connect("pressed", Network, "_on_HostButton_pressed")
	_err = $ConnectButton.connect("pressed", Network, "_on_ConnectButton_pressed", [$IP.text])
