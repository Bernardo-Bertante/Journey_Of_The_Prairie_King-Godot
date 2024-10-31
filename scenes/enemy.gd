extends CharacterBody2D

var speed = 50

signal perkAvailable(pos)
signal updateScore

func _ready() -> void:
	if $NavigationAgent2D.is_navigation_finished():
		return
	$NavigationAgent2D.target_position = Globals.player_pos
	
	

func _physics_process(_delta: float) -> void:
	var next_path_pos: Vector2 = $NavigationAgent2D.get_next_path_position()
	var direction: Vector2 = (next_path_pos - global_position).normalized()
	velocity = direction * speed
	move_and_slide()


func _on_timer_timeout() -> void:
	$explosion.hide()
	$AnimatedSprite2D.play("default")
	$NavigationAgent2D.target_position = Globals.player_pos

func hit() -> void:
	updateScore.emit()
	$explosion.show()
	$AnimatedSprite2D.hide()
	$ShaderTimer.start()
	if (randi() % 100) > 85:
		perkAvailable.emit(global_position)
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if body.has_method("hit"):
			body.hit() 
	queue_free()


func _on_shader_timer_timeout() -> void:
	queue_free()
