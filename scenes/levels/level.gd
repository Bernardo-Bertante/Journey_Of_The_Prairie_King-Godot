extends Node2D
class_name level

var gunPerk: PackedScene = preload("res://scenes/gun_perk.tscn")
var bullet_scene: PackedScene = preload("res://scenes/bullet.tscn")
var player: PackedScene = preload("res://scenes/player.tscn")
var enemies: PackedScene = preload("res://scenes/enemy.tscn")

@onready var score_text: Label = $Label

func _ready() -> void:
	score_text.text = str(Globals.score)
	


func _on_player_bullet(pos, direction) -> void:
	var bullet = bullet_scene.instantiate() as Area2D
	bullet.position = pos
	bullet.direction = direction 
	$Projectiles.add_child(bullet)

func spawn_player() -> void:
	var new_player = player.instantiate()
	add_child(new_player)
	new_player.global_position = get_viewport().size / 2
	new_player.connect("bullet", Callable(self, "_on_player_bullet"))
	new_player.connect("death", Callable(self, "_on_player_death"))
	new_player.connect("powerUp", Callable(self, "_on_player_power_up"))

func _on_player_death() -> void:
	spawn_player() 

func spawn_enemies() -> void:
	var viewport_size = get_viewport().size  # Tamanho da janela de visualização (viewport)
	
	# Posições dos quatro cantos cardeais
	var north_pos = Vector2(viewport_size.x / 2, -20)  # Centro no topo (norte)
	var south_pos = Vector2(viewport_size.x / 2, viewport_size.y + 20)  # Centro na parte inferior (sul)
	var east_pos = Vector2(viewport_size.x + 20, viewport_size.y / 2)  # Direita, no meio (leste)
	var west_pos = Vector2(-20, viewport_size.y / 2)  # Esquerda, no meio (oeste)

	spawn_enemy_at_position(north_pos)  # Norte
	spawn_enemy_at_position(south_pos)  # Sul
	spawn_enemy_at_position(east_pos)   # Leste
	spawn_enemy_at_position(west_pos)   # Oeste

func spawn_enemy_at_position(pos: Vector2) -> void:
	var new_enemy = enemies.instantiate()  # Cria uma nova instância do inimigo
	$Enemies.add_child(new_enemy)  # Adiciona o inimigo à cena no nó "Enemies"
	new_enemy.global_position = pos  # Define a posição do inimigo
	new_enemy.connect("perkAvailable", Callable(self, "_on_enemy_hit"))
	new_enemy.connect("updateScore", Callable(self, "_update_score"))
	
func _on_enemy_hit(pos) -> void:
	var perk = gunPerk.instantiate()
	perk.global_position = pos
	call_deferred("add_child", perk)
	
func _update_score() -> void:
	Globals.score += 1
	score_text.text = str(Globals.score)
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(score_text.label_settings, "font_color", Color(0,1,0), 0.05)
	tween.tween_property(score_text.label_settings, "font_size", 42, 0.05)
	tween.set_parallel(false)
	tween.tween_property(score_text.label_settings, "font_color", Color(1,1,1), 0.05)
	tween.tween_property(score_text.label_settings, "font_size", 40, 0.05)
	


func _on_timer_timeout() -> void:
	spawn_enemies()

func _on_player_power_up(pos: Variant) -> void:
	_on_player_bullet(pos, Vector2.UP)
	_on_player_bullet(pos, Vector2.DOWN)
	_on_player_bullet(pos, Vector2.LEFT)
	_on_player_bullet(pos, Vector2.RIGHT)
	_on_player_bullet(pos, Vector2.from_angle(PI / 4))
	_on_player_bullet(pos, Vector2.from_angle(3*PI / 4))
	_on_player_bullet(pos, Vector2.from_angle(5*PI / 4))
	_on_player_bullet(pos, Vector2.from_angle(7*PI / 4))
