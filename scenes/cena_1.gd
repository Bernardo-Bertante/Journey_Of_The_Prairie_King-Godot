extends CanvasLayer

class_name cenas

func _ready() -> void:
	$Timer.start()

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level1.tscn")