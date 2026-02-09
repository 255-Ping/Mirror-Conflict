extends Node2D

@export var door_id: String

func _ready():
	var player = get_parent().get_node("Player")
	player.door_triggered.connect(_on_door_triggered)
	
func _on_door_triggered(incoming_door_id: String):
	if door_id == incoming_door_id:
		queue_free()
