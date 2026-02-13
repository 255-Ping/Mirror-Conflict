extends Node2D

var rng = RandomNumberGenerator.new()

@onready var crate = preload("res://Scenes/WorldObjects/crate.tscn")

@export var crate_spawn_timer_time: float
var crate_spawn_timer: float

@export var spawn_amount: int

@export var spawn_range: Vector2

func _ready() -> void:
	crate_spawn_timer = crate_spawn_timer_time


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if crate_spawn_timer > 0:
		crate_spawn_timer -= delta
	else:
		crate_spawn_timer = crate_spawn_timer_time
		print("spawned initial")
		
		for i in spawn_amount:
			print(i)
			var instance = crate.instantiate()
			
			instance.global_position = global_position + Vector2(
			rng.randf_range(spawn_range.x, spawn_range.x * -1),
			rng.randf_range(spawn_range.y, spawn_range.y * -1))
			
			get_parent().add_child(instance)
