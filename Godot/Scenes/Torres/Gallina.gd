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
	attack_sound.play()
	for i in enemy_array:
		i.on_hit(Data.tower_data[type]["damage"])
	yield(get_tree().create_timer(Data.tower_data[type]["rof"]), "timeout")
	ready = true
	
func _on_Rango_body_entered(body):
	enemy_array.append(body.get_parent())
	
func _on_Rango_body_exited(body):
	enemy_array.erase(body.get_parent())


func _on_Gallina_tree_entered():
	$SoundPick.play()
