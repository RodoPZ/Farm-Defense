extends CanvasLayer

func set_tower_preview(tower_type, mouse_position):
	var drag_tower = load("res://Scenes/Torres/" + tower_type + ".tscn").instance()
	drag_tower.set_name("DragTower")
	#drag_tower.modulate = color("ad54ff3c")
	
	var control = Control.new()
	control.add_child(drag_tower, true)
	control.rect_position = mouse_position
	control.set_name("TowerPreview")
	add_child(control,true)
	#move_child(get("TowerPreview"),0)
	
	
func _on_pause_pressed():
	get_tree().paused = true	

func _on_play_pressed():
	get_tree().paused = false	

func _on_accel_toggled(button_pressed):
		if button_pressed == true:
			Engine.set_time_scale(2)
		else:
			Engine.set_time_scale(1)
			
