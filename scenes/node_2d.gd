extends CanvasLayer

var next_level: PackedScene = preload("res://scenes/levels/level2.tscn")

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_packed(next_level)
