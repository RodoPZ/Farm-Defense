extends "res://Scenes/Torres/Torres.gd"
func turn():
	animate()

func animate():
	if ready == false:
		animated_sprite.play("attack_right")
	else: 
		animate_idle()
		
func select_enemy():
	pass

func fire():
	ready = false
	yield(get_tree().create_timer(Data.tower_data[type]["rof"]), "timeout")
	ready = true

func _on_Rango_body_entered(body):
	enemy_array.append(body.get_parent())	
	if built: 
		body.get_parent().slow_speed(true,Data.tower_data[type]["damage"])
	
func _on_Rango_body_exited(body):
	enemy_array.erase(body.get_parent())
	if built: 
		body.get_parent().slow_speed(false,Data.tower_data[type]["damage"])

func _on_Puerco_tree_entered():
	$SoundPick.play()
