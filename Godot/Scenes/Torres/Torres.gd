extends Node2D

#cuadrantes
#


func _physics_process(delta):
	turn()
	
func turn():
	var enemy_pos = get_global_mouse_position()
	var pos_actual = self.position
	#1
	if(enemy_pos[0] > pos_actual[0] and enemy_pos[1] < pos_actual[1]):
		get_node("Torre").look_at(enemy_pos)
	
	
	

