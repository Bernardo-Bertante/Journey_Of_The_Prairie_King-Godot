extends level

var next1_level: PackedScene = preload("res://scenes/cena2.tscn")

func _ready() -> void:
	super._ready()
	$Timers/FinishLevel.start()
	await $Timers/FinishLevel.timeout
	get_tree().change_scene_to_packed(next1_level)
