extends Node2D

func _ready() -> void:
	$ColorRect.color = Color(0,1,0,1)
	


func _on_detection_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$ColorRect.color = Color(1,1,0,1)
		await get_tree().create_timer(0.5).timeout
		$ColorRect.color = Color(1,0,0,1)
		await get_tree().create_timer(0.5).timeout
		queue_free()
