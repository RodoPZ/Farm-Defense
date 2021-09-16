extends "res://Scenes/Torres/Torres.gd"



func fire():
	ready = false
	enemy.on_hit(Data.tower_data[type]["damage"])
	yield(get_tree().create_timer(Data.tower_data[type]["rof"]), "timeout")
	ready = true


