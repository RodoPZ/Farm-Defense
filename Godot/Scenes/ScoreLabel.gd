extends Label

func _process(_delta):
	#$self.text = Data.player["Player"]["score"]
	set_text(str(Data.player["Player"]["score"]))
