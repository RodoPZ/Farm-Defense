extends "res://Scenes/Torres/Torres.gd"

func _process(delta):
	if Data.player["Player"]["paused"]:
		$Timer.set_paused(true)
	else:
		$Timer.set_paused(false)
	
func _on_Timer_timeout():
	if is_atacking:
		animated_sprite.play("attack")
	pass # Replace with function body.

func _on_Torre_animation_finished():
	if animated_sprite.animation == "attack":
		is_atacking = true
		$Leche.show()
		animated_sprite.play("idle")

func _on_Leche_pressed():
	Data.player["Player"]["leche"] += 1
	$Leche.hide()
	

