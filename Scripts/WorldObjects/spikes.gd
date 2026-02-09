extends Sprite2D


func _on_kill_box_body_entered(body: Node2D) -> void:
	if !body.is_in_group("player"):
		return
	$AudioStreamPlayer2D.play()
	body.death()
