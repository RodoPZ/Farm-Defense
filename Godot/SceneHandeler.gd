extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
# warning-ignore:return_value_discarded
	get_node("MainMenu/M/VB/Start").connect("pressed", self, "on_new_game_pressed")

func on_new_game_pressed():
	get_node("MainMenu").queue_free()
	var game_scene = load("res://Scenes/Gamescene.tscn").instance()
	add_child(game_scene)

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
