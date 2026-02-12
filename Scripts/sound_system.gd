extends Node
class_name PingSound

func play_sound(sound: AudioStream, location: Vector2):
	var sound_player = AudioStreamPlayer2D.new()
	sound_player.stream = sound
	sound_player.global_position = location
	get_tree().current_scene.add_child(sound_player)
	sound_player.play()
