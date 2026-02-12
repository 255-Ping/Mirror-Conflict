extends Node2D

@export var door_id: String

@onready var door_open_sound = preload("res://Sounds/Door Open 1.ogg")

func _ready():
	var player = get_parent().get_node("Player")
	player.door_triggered.connect(_on_door_triggered)
	
func _on_door_triggered(incoming_door_id: String):
	if door_id == incoming_door_id:
		SoundPing.play_sound(door_open_sound, global_position)
		queue_free()
