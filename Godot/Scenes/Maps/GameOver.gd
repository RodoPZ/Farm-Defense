extends Area2D


func _on_GameOver_body_entered(_body):
#	var game_scene = load("res://Scenes/GameOver.tscn").instance()
#	add_child(game_scene)
	Data.player["Player"]["hp"] -= 1
	if Data.player["Player"]["hp"] <= 0:
		Data.player["Player"]["game_over"] = true
		get_node(".").queue_free()
		get_tree().change_scene("res://SceneHandeler.tscn")

