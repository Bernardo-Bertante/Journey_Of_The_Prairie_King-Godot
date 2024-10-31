extends level

var next2_level: PackedScene = preload("res://scenes/cena3.tscn")

func _ready() -> void:
	super._ready()
	$Timers/FinishLevel.start()
	await $Timers/FinishLevel.timeout
	get_tree().change_scene_to_packed(next2_level)
