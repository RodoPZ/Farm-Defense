extends PathFollow2D
var tower_type = null
var speed = 0

func _ready():
	connect("", self, "signal")
	speed = Data.enemigos[name]["speed"]	

func _physics_process(delta):
	move(delta)

func move(delta):
	set_offset(get_offset() + speed *delta)


