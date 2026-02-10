extends Node2D


func _on_texture_button_pressed() -> void:
	SceneLoader.load_scene("res://Scenes/Levels/level_1.tscn")
