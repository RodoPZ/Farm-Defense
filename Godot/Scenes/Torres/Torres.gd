extends Node2D
var mover = false	
var pos_actual = self.position


func _on_Rango_body_entered(body):
	mover = true
func _on_Rango_body_exited(body):
	mover = false


func _on_Derecha_body_entered(body):
	print("Sprite_Derecha")
	#animated_sprite.play("attack_right")
func _on_Abajo_body_entered(body):
	print("Sprite_Abajo")
func _on_Izquierda_body_entered(body):
	print("Sprite_Izquierda")
func _on_Arriba_body_entered(body):
	print("Sprite_Arriba")
