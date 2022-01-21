extends Control

func _on_MainMenu_visibility_changed():
	if Data.player["Player"]["game_over"] == false:
		$MusicMainMenu.play()
