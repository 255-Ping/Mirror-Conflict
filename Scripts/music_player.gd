extends Node

var music: AudioStreamPlayer

@onready var sound_music_1 = preload("res://Sounds/2016_ Clement Panchout_ Life is full of Joy.wav")

#func _process(delta: float) -> void:
#	if !$AudioStreamPlayer.playing:
#		$AudioStreamPlayer.play()

func _ready() -> void:
	await get_tree().process_frame
	music = AudioStreamPlayer.new()
	music.stream = sound_music_1
	music.volume_db = -17.5
	add_child(music)
	
func _process(delta: float) -> void:
	if !music.playing:
		music.play()
