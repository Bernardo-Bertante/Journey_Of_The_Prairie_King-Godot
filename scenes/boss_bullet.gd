extends Area2D

var speed:int = 500
var direction: Vector2 = Vector2.UP

func _process(delta: float) -> void:
	position += delta * speed * direction


func _on_timer_timeout() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.hit()
	queue_free()


func _on_shoot_timeout() -> void:
	pass # Replace with function body.
