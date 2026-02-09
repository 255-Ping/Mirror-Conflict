extends CharacterBody2D


const SPEED = 250.0
const JUMP_VELOCITY = -400.0

var pushing_targets: Array
var other_player: Node
var is_dying: bool = false

var was_on_floor := false

@onready var camera = $Camera2D
@onready var ui = $Control
@onready var step_particle = preload("res://Scenes/step_particle.tscn")

@onready var jump_sound = preload("res://Sounds/Dirt Jump.ogg")
@onready var land_sound = preload("res://Sounds/Dirt Land.ogg")
@onready var run_sound = preload("res://Sounds/Dirt Run 3.ogg")

func _ready() -> void:
	_update_other_player_var()

func _physics_process(delta):
	var on_floor := is_on_floor()

	if on_floor and not was_on_floor:
		$AudioStreamPlayer2D.stream = land_sound
		$AudioStreamPlayer2D.volume_db = -10
		$AudioStreamPlayer2D.pitch_scale = 0.7
		$AudioStreamPlayer2D.play()

	was_on_floor = on_floor
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		$AudioStreamPlayer2D.stream = jump_sound
		$AudioStreamPlayer2D.volume_db = -10
		$AudioStreamPlayer2D.pitch_scale = 0.9
		$AudioStreamPlayer2D.play()
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction
	if camera.is_current():
		direction = Input.get_axis("move_left", "move_right")
	else:
		direction = Input.get_axis("move_right", "move_left")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	_animation_control()
	_push_targets()
	
func death():
	is_dying = true
	$AnimatedSprite2D.play("death")
	await get_tree().create_timer(1.0).timeout
	get_parent().next_level()
	queue_free()
	
func _update_other_player_var():
	for node in get_parent().get_children():
		if node.is_in_group("player") and node != self:
			other_player = node
	
func _animation_control():
	if is_dying:
		return
	if Input.is_action_pressed("move_right"):
		if !$AudioStreamPlayer2D.playing:
			$AudioStreamPlayer2D.stream = run_sound
			$AudioStreamPlayer2D.volume_db = -15
			$AudioStreamPlayer2D.pitch_scale = 0.85
			$AudioStreamPlayer2D.play()
		
		if !$AnimatedSprite2D.animation == "walk_side":
			$AnimatedSprite2D.play("walk_side")
		if !is_on_floor():
			return
		var instance = step_particle.instantiate()
		if camera.is_current():
			instance.x_direction = -1
			$AnimatedSprite2D.flip_h = false
		else:
			instance.x_direction = 1
			$AnimatedSprite2D.flip_h = true
		instance.global_position = global_position
		get_parent().add_child(instance)
	elif Input.is_action_pressed("move_left"):
		if !$AudioStreamPlayer2D.playing:
			$AudioStreamPlayer2D.stream = run_sound
			$AudioStreamPlayer2D.volume_db = -15
			$AudioStreamPlayer2D.pitch_scale = 0.85
			$AudioStreamPlayer2D.play()
			
		#$AnimatedSprite2D.flip_h = true
		if !$AnimatedSprite2D.animation == "walk_side":
			$AnimatedSprite2D.play("walk_side")
		if !is_on_floor():
			return
		var instance = step_particle.instantiate()
		if camera.is_current():
			instance.x_direction = 1
			$AnimatedSprite2D.flip_h = true
		else:
			instance.x_direction = -1
			$AnimatedSprite2D.flip_h = false
		instance.global_position = global_position
		get_parent().add_child(instance)
	else:
		if !$AnimatedSprite2D.animation == "idle":
			$AnimatedSprite2D.play("idle")
	
func _push_targets():
	for target in pushing_targets:
		target.push(global_position)


func _on_push_box_body_entered(body: Node2D) -> void:
	if !body.is_in_group("pushable"):
		return
	pushing_targets.append(body)


func _on_push_box_body_exited(body: Node2D) -> void:
	if !body.is_in_group("pushable"):
		return
	pushing_targets.erase(body)
	
func push(from_position: Vector2, force := 100.0):
	var dir = (global_position - from_position).normalized()
	#global_position += dir * force
	#rotation_degrees = 0
	velocity += dir * force
	#apply_impulse(dir * force)
