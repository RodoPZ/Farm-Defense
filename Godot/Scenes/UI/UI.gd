extends CanvasLayer

func set_tower_preview(tower_type, mouse_position):
	var drag_tower = load("res://Scenes/Torres/" + tower_type + ".tscn").instance()
	drag_tower.set_name("DragTower")
	drag_tower.modulate = Color("ad54ff3c")
	
	var range_texture = Sprite.new()
	range_texture.position = Vector2(8,8)
	var scaling = Data.tower_data[tower_type]["range"] / 3.0
	range_texture.scale = Vector2(scaling, scaling)
	var texture = load("res://Assets/GUI/range_overlay.png")
	range_texture.texture = texture
	range_texture.modulate = Color("ad54ff3c")
	
	var control = Control.new()
	control.add_child(drag_tower, true)
	control.add_child(range_texture,true)
	control.rect_position = mouse_position
	control.set_name("TowerPreview")
	add_child(control,true)
	move_child(get_node("TowerPreview"),0)
	
func update_tower_preview(new_position, color):
	get_node("TowerPreview").rect_position = new_position
	if get_node("TowerPreview/DragTower").modulate != Color(color):
		get_node("TowerPreview/DragTower").modulate = Color(color)
		get_node("TowerPreview/Sprite").modulate = Color(color)
	

##
## Funciones de botones
##

func _on_pause_toggled(_button_pressed):
	$SoundButtonPressed.play()
	if get_tree().is_paused():
		Data.player["Player"]["paused"] = false
		get_tree().paused = false
	elif get_parent().current_wave == 0:
		Data.player["Player"]["paused"] = false
		get_parent().current_wave += 1
		get_parent().start_next_wave()
	else:
		Data.player["Player"]["paused"] = true
		get_tree().paused = true
		

func _on_accel_toggled(button_pressed):
	$SoundButtonPressed.play()
	if button_pressed:
		Engine.set_time_scale(1.5)
	else:
		Engine.set_time_scale(1)
			


func _on_MusicButton_toggled(_button_pressed):
	$SoundButtonPressed.play()
	if get_node("MusicLevel").stream_paused == false:
		get_node("MusicLevel").stream_paused = true
	else:
		get_node("MusicLevel").stream_paused = false
