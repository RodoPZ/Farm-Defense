extends PathFollow2D
var tower_type = null
var enemy_name = ""
var is_dead = false
var hp = 50
var original_speed = 0
var current_speed = 0
onready var animated_sprite : AnimatedSprite = get_node("KinematicBody2D/Enemigo")
onready var health_bar = get_node("HealthBar")


func _init(_enemy_name = 0).():
	enemy_name = _enemy_name
	
func _ready():
	hp = Data.enemigos[enemy_name]["hp"]	
	health_bar.max_value = hp
	health_bar.value = hp
	original_speed = Data.enemigos[enemy_name]["speed"]
	current_speed = original_speed
#	health_bar.set_as_toplevel(true)



func _physics_process(delta):
	if is_dead == false:
		set_offset(get_offset() + current_speed* delta)
	else:
		set_offset(get_offset() + 0 * delta)

func slow_speed(mod,slow_ratio):
	if mod:
		current_speed = original_speed*slow_ratio
	else: 
		current_speed = original_speed*1
	return current_speed

func on_hit(damage):
	hp -= damage
	health_bar.value = hp
	if hp <= 0:
		on_destroy()
		#NOTA solo para slime, generalizar #Listones 
		Data.player["Player"]["score"] += Data.enemigos[enemy_name]["score"]
		
func on_destroy():
	is_dead = true
	get_node("KinematicBody2D").set_collision_layer_bit(0,false)
	get_node("KinematicBody2D").set_collision_mask_bit(0,false)
	animated_sprite.play("death")

func _on_Enemigo_animation_finished():
	if is_dead == true:
		queue_free()
