extends Label

onready var path_follow = get_parent()

export var _speed = 100
	
func _physics_process(delta):
	path_follow.set_offset(path_follow.get_offset() + _speed * delta)

func _on_WaveLabel_visibility_changed():
	if $".".visible:
		path_follow.unit_offset = 0
