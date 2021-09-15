extends Area2D

func _on_GameOver1_body_entered(_body):
	Data.player["Player"]["hp"] -= 1
	if Data.player["Player"]["hp"] <= 0:
		Data.player["Player"]["game_over"] = true
		get_node(".").queue_free()
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://SceneHandeler.tscn")

