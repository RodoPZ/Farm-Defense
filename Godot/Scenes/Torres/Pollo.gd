extends Node2D

#cuadrantes
#
var pos_actual = self.position


func _on_Abajo_mouse_entered():
	get_node("Torre").look_at(Vector2(pos_actual[0],pos_actual[1]+50))

func _on_Derecha_mouse_entered():
	get_node("Torre").look_at(Vector2(pos_actual[0]+50,pos_actual[1]))

func _on_Izquierda_mouse_entered():
	get_node("Torre").look_at(Vector2(pos_actual[0],pos_actual[1]-50))

func _on_Arriba_mouse_entered():
	get_node("Torre").look_at(Vector2(pos_actual[0]-50,pos_actual[1]))
