extends Control

func _on_GameOver_visibility_changed():
	if Data.player["Player"]["game_over"]:
		$MusicGameOver.play()
		Data.player["Player"]["game_over"] = false
