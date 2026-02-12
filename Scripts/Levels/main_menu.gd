extends Node2D

func _on_play_button_pressed() -> void:
	SceneLoader.load_scene("res://Scenes/Levels/level_1.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
