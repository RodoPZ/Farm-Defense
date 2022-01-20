extends Node

var game_scene
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("MainMenu/M/VB/Start").connect("pressed", self, "on_new_game_pressed")
	get_node("MainMenu/M/VB/Start/CreditsButton").connect("pressed", self, "on_credits_pressed")
	
func on_new_game_pressed():
	$SoundButtonPressed.play()
	get_node("MainMenu").queue_free()
	game_scene = load("res://Scenes/Main/Gamescene.tscn").instance()
	add_child(game_scene)

func on_credits_pressed():
	$SoundButtonPressed.play()
	get_node("MainMenu").queue_free()
	game_scene = load("res://Scenes/Main/Credits.tscn").instance()
	add_child(game_scene)

func _process(_delta):
	if Data.player["Player"]["game_over"]:
		$MainMenu.hide()
		$GameOver.show()
		
func _unhandled_input(event):
	if event.is_action_released("restart") and $GameOver.visible:
		$MainMenu.show()
		$GameOver.hide()
		Data.player["Player"]["score"] = 0
		Data.player["Player"]["leche"] = 2
		Data.player["Player"]["hp"] = 3
		Data.player["Player"]["game_over"] = false
		Data.player["Player"]["paused"] = false
