extends "res://Scenes/Torres/Torres.gd"

func _on_Timer_timeout():
	if anim_free == true:
		anim_free = false
		animated_sprite.play("attack")
	pass # Replace with function body.

func _on_Torre_animation_finished():
	if animated_sprite.animation == "attack":
		anim_free = true
		$Leche.show()
		animated_sprite.play("idle")


func _on_Leche_pressed():
	Data.player["Player"]["leche"] += 1
	$Leche.hide()
