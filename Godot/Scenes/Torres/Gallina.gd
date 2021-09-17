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
	for i in enemy_array:
		i.on_hit(Data.tower_data[type]["damage"])
	yield(get_tree().create_timer(Data.tower_data[type]["rof"]), "timeout")
	ready = true
	

