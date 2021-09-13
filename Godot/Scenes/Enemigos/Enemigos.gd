extends PathFollow2D
var tower_type = null
var tower_name = ""
var speed = 0
var hp = 50
onready var animated_sprite : AnimatedSprite = get_node("KinematicBody2D/Enemigo")
onready var health_bar = get_node("HealthBar")

func _init(_tower_name = 0).():
	tower_name = _tower_name
	
func _ready():
	speed = Data.enemigos[tower_name]["speed"]	
	hp = Data.enemigos[tower_name]["hp"]	
	health_bar.max_value = hp
	health_bar.value = hp
	#comenté connect porque daba errores Rodo

#	health_bar.set_as_toplevel(true)



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
