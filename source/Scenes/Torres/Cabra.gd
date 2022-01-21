extends "res://Scenes/Torres/Torres.gd"

func fire():
	ready = false
	attack_sound.play()
	enemy.on_hit(Data.tower_data[type]["damage"])
	yield(get_tree().create_timer(Data.tower_data[type]["rof"]), "timeout")
	ready = true

func _on_SoundPick_tree_entered():
	$SoundPick.play()
