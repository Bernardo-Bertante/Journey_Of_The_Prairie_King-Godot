extends cenas

func _ready() -> void:
	$Label.text = "Com a última bala de ouro, Drácula cai, e o coração roubado retorna à sua verdadeira dona. 
O cowboy se aproxima dela, e em um beijo, sela o fim de sua jornada. 
Ao olhar para trás, ele murmura: 
'" + str(Globals.score) + " almas foram libertas hoje. Finalmente, a paz reina novamente.'"
	
	var tween = get_tree().create_tween()
	tween.tween_property($Label, "modulate", Color(1,1,1,1), 2.5).from(Color(1,1,1,0))
	tween.tween_property($TextureRect, "modulate", Color(1,1,1,1), 1).from(Color(1,1,1,0))

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("enter"):
		get_tree().change_scene_to_file("res://scenes/menu.tscn")
		
