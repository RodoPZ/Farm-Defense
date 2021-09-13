extends Node

var game_scene

# Called when the node enters the scene tree for the first time.
func _ready():
# warning-ignore:return_value_discarded
	get_node("MainMenu/M/VB/Start").connect("pressed", self, "on_new_game_pressed")

func on_new_game_pressed():
	get_node("MainMenu").queue_free()
	game_scene = load("res://Scenes/Gamescene.tscn").instance()
	add_child(game_scene)
	
func _process(_delta):
	if Data.player["Player"]["game_over"]:
		$MainMenu.hide()
		$GameOver.show()
	
	#if $GameOver.visible:
		#unhandled_input(event)
		#game_scene = load("res://Scenes/UI/GameOver.tscn").instance()
	
func _unhandled_input(event):
	if event.is_action_released("restart") and $GameOver.visible:
		$MainMenu.show()
		$GameOver.hide()
		Data.player["Player"]["score"] = 0
		Data.player["Player"]["leche"] = 2
		Data.player["Player"]["hp"] = 3
		Data.player["Player"]["game_over"] = false
		Data.player["Player"]["paused"] = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
