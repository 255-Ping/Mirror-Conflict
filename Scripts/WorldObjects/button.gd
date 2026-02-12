extends Area2D

@export var door_id: String

func play_sound():
	$AudioStreamPlayer2D.play()
