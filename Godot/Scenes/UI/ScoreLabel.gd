extends Label

func _process(_delta):
	set_text(str(Data.player["Player"]["score"]))
