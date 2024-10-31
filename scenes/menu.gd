extends CanvasLayer

func _ready() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($TextureRect, "scale", Vector2(4, 4), 1).from(Vector2(0, 0))
	Globals.score = 0
	



func _on_timer_timeout_menu() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($TextureRect, "scale", Vector2(3.8, 3.8), 0.5).from(Vector2(4, 4))
	tween.tween_property($TextureRect, "scale", Vector2(4, 4), 0.5).from(Vector2(3.8, 3.8))

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		get_tree().change_scene_to_file("res://scenes/cena1.tscn")
		
