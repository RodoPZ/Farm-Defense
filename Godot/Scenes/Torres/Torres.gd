extends Node2D
var mover = false	
var pos_actual = self.position

func _physics_process(delta):
	if (mover == true):	
		var enemy_pos = get_global_mouse_position()
		get_node("Torre").look_at(enemy_pos)

func _on_Rango_mouse_entered():
	mover = true
func _on_Rango_mouse_exited():
	mover = false

func _on_Abajo_mouse_entered():
	print("Sprite_Abajo")
func _on_Derecha_mouse_entered():
	print("Sprite_Derecha")
func _on_Izquierda_mouse_entered():
	print("Sprite_Izquierda")
func _on_Arriba_mouse_entered():
	print("Sprite_Arriba")
