extends PathFollow2D

var speed = 0

func _ready():
	connect("", self, "signal")
	
func _physics_process(delta):
	move(delta)

func move(delta):
	set_offset(get_offset() + speed *delta)


