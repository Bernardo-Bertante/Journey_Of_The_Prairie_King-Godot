extends Camera2D

var shake_time = 0
var shake_intensity = 10


func shake(duration: float, intensity: float):
	shake_time = duration
	shake_intensity = intensity
	

func _process(delta):
	if shake_time > 0:
		shake_time -= delta
		offset = Vector2(randf_range(-shake_intensity, shake_intensity), randf_range(-shake_intensity, shake_intensity))
	else:
		offset = Vector2.ZERO
