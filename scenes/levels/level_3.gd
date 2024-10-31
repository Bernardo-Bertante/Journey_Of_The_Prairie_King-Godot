extends level

var Draco_bullet_scene: PackedScene = preload("res://scenes/boss_bullet.tscn")
var next3_level: PackedScene = preload("res://scenes/cenaFinal.tscn")

func  _ready() -> void:
	super._ready()
	$Timers/Timer.stop()


func _on_node_2d_boss_bullet(pos: Variant) -> void:
	var Dracobullet = Draco_bullet_scene.instantiate() as Area2D
	Dracobullet.position = pos
	$Projectiles.add_child(Dracobullet)

func _process(_delta: float) -> void:
	if not $Enemies/Node2D:
		get_tree().change_scene_to_packed(next3_level)
