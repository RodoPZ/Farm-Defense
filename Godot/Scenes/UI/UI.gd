extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_pause_pressed():
	get_tree().paused = true	

func _on_play_pressed():
	get_tree().paused = false	

func _on_accel_toggled(button_pressed):
		if button_pressed == true:
			Engine.set_time_scale(2)
		else:
			Engine.set_time_scale(1)
			
