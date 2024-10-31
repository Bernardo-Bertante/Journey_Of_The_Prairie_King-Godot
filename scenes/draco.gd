extends CharacterBody2D

var vector: Vector2 = Vector2(0, -35)
var direction: int = 1
var life: int = 20

signal boss_bullet(pos)
@onready var invencible = true

func _ready() -> void:
	$puff.hide()
	var tween = get_tree().create_tween()
	tween.tween_property($dialoguebox, "position", vector, 1.5)
	$Timer2.start()
	
	

func _on_timer_timeout() -> void:
	$dialoguebox.queue_free()
	$AnimatedSprite2D.hide()
	$Timer3.start()
	$puff.show()
	

func _on_timer_2_timeout() -> void:
	
	var walkTween = get_tree().create_tween()
	if direction == 1:
		walkTween.tween_property(self, "global_position", Vector2(580, global_position.y), 6)
		direction = -1
	elif direction == -1:
		walkTween.tween_property(self, "global_position", Vector2(50, global_position.y), 6)
		direction = 1
	
		
func hit() -> void:
	if not invencible:
		life -= 1
		$AnimatedSprite2D.material.set_shader_parameter("progress", 1)
		if life == 0:
			queue_free()
		$AnimatedSprite2D/TimerShader.start()
	
func _on_timer_shader_timeout() -> void:
	$AnimatedSprite2D.material.set_shader_parameter("progress", 0)


func _on_timer_3_timeout() -> void:
	position = position + Vector2(-280, 0)
	$AnimatedSprite2D.show()
	$puff.hide()
	$Shoot.start()
	invencible = false
	$AnimatedSprite2D.play("default")


func _on_shoot_timeout() -> void:
	boss_bullet.emit(position)
