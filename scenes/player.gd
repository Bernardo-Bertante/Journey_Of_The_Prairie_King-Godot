extends CharacterBody2D

var speed: int = 150
var power_up: bool = false
@onready var invencible: bool = true

signal bullet(pos, direction)
signal death
signal powerUp(pos)

func _ready() -> void:
	Globals.player_pos = position
	$AnimatedSprite2D.play("idle")

func _process(delta: float) -> void:
	Globals.player_pos = position
	var direction = Input.get_vector("left", "right", "up", "down")
	position += direction * speed * delta
	if direction != Vector2.ZERO:
		if abs(direction.x) > abs(direction.y):
			# Movendo para esquerda ou direita
			if direction.x > 0:
				$AnimatedSprite2D.play("right")
			else:
				$AnimatedSprite2D.play("left")
		else:
			# Movendo para cima ou para baixo
			if direction.y > 0:
				$AnimatedSprite2D.play("down")
			else:
				$AnimatedSprite2D.play("up")
	else:
		# Se não houver movimento, pare a animação
		$AnimatedSprite2D.play("idle")
	move_and_slide()
	
	if Input.is_action_just_pressed("shoot"):
		var bullet_direction = direction
		if bullet_direction.is_zero_approx():
			bullet_direction = Vector2.DOWN
		if power_up:
			powerUp.emit(position)
		else:
			bullet.emit(position, bullet_direction)
		

func hit() -> void:
	if not invencible:
		$AnimatedSprite2D.hide()
		$Camera2D.shake(0.2, 5)
		power_up = false
		$Timer.start(0.1)
		await $Timer.timeout
		death.emit()
		queue_free()

func _on_invencible_timeout() -> void:
	invencible = false

func verify_power_up() -> void:
	power_up = true
