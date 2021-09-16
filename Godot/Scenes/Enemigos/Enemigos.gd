extends PathFollow2D
var tower_type = null
var tower_name = ""
var speed = 0
var is_dead = false
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
  
#	health_bar.set_as_toplevel(true)



func _physics_process(delta):
	if is_dead == false:
		set_offset(get_offset() + speed * delta)
	else:
		set_offset(get_offset() + 0 * delta)

func on_hit(damage):
	hp -= damage
	health_bar.value = hp
	if hp <= 0:
		on_destroy()
		#NOTA solo para slime, generalizar #Listones 
		Data.player["Player"]["score"] += Data.enemigos[tower_name]["score"]
		
func on_destroy():
	is_dead = true
	get_node("KinematicBody2D").set_collision_layer_bit(0,false)
	get_node("KinematicBody2D").set_collision_mask_bit(0,false)
	animated_sprite.play("death")

func _on_Enemigo_animation_finished():
	if is_dead == true:
		queue_free()
