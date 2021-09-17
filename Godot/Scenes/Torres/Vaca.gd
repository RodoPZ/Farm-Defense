extends Node2D
var is_attacking = false
var built = false
var type
onready var animated_sprite : AnimatedSprite = get_node("Torre")
onready var sound_attack : AudioStreamPlayer = get_node("SoundAttack")

func _ready():
	$Timer.wait_time = Data.tower_data["Vaca"]["drop_time"]

func _process(_delta):
	if Data.player["Player"]["paused"]:
		$Timer.set_paused(true)
	else:
		$Timer.set_paused(false)
	
func _on_Timer_timeout():
	if is_attacking == false:
		#sound_attack.play()
		animated_sprite.play("attack")
		is_attacking = true

func _on_Torre_animation_finished():
	if is_attacking:
		is_attacking = false
		$Leche.show()
		animated_sprite.play("idle")

func _on_Leche_pressed():
	if Data.player["Player"]["leche"] < 99:
		Data.player["Player"]["leche"] += 1
	$Leche.hide()
	$SoundPickMilk.play()
	
func _on_Vaca_tree_entered():
	#El if es para que la vaca puesta por default no muja
	if self.name != "Vaca":
		$SoundPick.play()
