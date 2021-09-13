extends PathFollow2D
var tower_type = null
var speed = 30
var hp = 50
onready var animated_sprite : AnimatedSprite = get_node("KinematicBody2D/Enemigo")
onready var health_bar = get_node("HealthBar")

func _ready():
	health_bar.max_value = hp
	health_bar.value = hp
#	health_bar.set_as_toplevel(true)

#func _ready():
	#comenté connect porque daba errores Rodo
	#connect("", self, "signal")
	#speed = Data.enemigos[name]["speed"]	

func _physics_process(delta):
	move(delta)

func move(delta):
	set_offset(get_offset() + speed * delta)
#	health_bar.set_position(position - Vector2(17,6))

func on_hit(damage):
	hp -= damage
	health_bar.value = hp
	if hp <= 0:
		on_destroy()
		#NOTA solo para slime, generalizar
		Data.player["Player"]["score"] += Data.enemigos["Slime"]["score"]
func on_destroy():
	self.queue_free()
