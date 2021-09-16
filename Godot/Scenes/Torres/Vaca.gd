extends "res://Scenes/Torres/Torres.gd"
var is_attacking = false
func _process(_delta):
	if Data.player["Player"]["paused"]:
		$Timer.set_paused(true)
	else:
		$Timer.set_paused(false)
	
func _on_Timer_timeout():
	if not is_attacking:
		animated_sprite.play("attack")
		is_attacking = true

func _on_Torre_animation_finished():
	if is_attacking:
		is_attacking = false
		$Leche.show()
		animated_sprite.play("idle")

func _on_Leche_pressed():
	Data.player["Player"]["leche"] += 1
	$Leche.hide()
	

