extends RigidBody2D

func _ready() -> void:
	lock_rotation = true


func push(from_position: Vector2, force := 1.0):
	var dir = (global_position - from_position).normalized()
	global_position += dir * force
	#rotation_degrees = 0
	#apply_impulse(dir * force)


func _on_kill_box_body_entered(body: Node2D) -> void:
	$AudioStreamPlayer2D.play()
	if !body.is_in_group("player"):
		return
	if linear_velocity.y != 0:
		body.death()
