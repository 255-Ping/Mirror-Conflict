extends Node2D

var rng = RandomNumberGenerator.new()

var x_direction: int

var current_y: float

var life_time: float

func _ready() -> void:
	if rng.randf_range(0,1) > 0.25:
		queue_free()
	current_y = rng.randf_range(-0.25,-0.1)
	life_time = rng.randf_range(0.25,0.75)
	scale = Vector2(rng.randf_range(0.25,1),rng.randf_range(0.25,1))
	global_position.y += 6

func _process(delta: float) -> void:
	global_position += Vector2(x_direction * 0.1,current_y)
	rotation_degrees += rng.randf_range(5,15)
	if life_time > 0:
		life_time -= delta
	else:
		queue_free()
