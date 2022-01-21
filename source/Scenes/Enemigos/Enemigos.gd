extends PathFollow2D

var enemy_name = ""
var is_dead = false
var hp = 50
var original_speed = 0
var current_speed = 0
onready var animated_sprite : AnimatedSprite = get_node("KinematicBody2D/Enemigo")
onready var health_bar = get_node("HealthBar")
onready var sonido_puntos : AudioStreamPlayer = get_node("SonidoPuntos")

func _init(_enemy_name = 0).():
	enemy_name = _enemy_name
	
func _ready():
	var Gamescene = self.get_parent().get_parent().get_parent()
	var Mapa = Gamescene.get_child(0).name
	original_speed = Data.enemigos[enemy_name]["speed"]
	current_speed = original_speed	
	hp = Data.enemigos[enemy_name]["hp"] * (1 + (Gamescene.current_wave-2)*Data.wave_data[Mapa]["hp_inc_rate"])
	health_bar.max_value = hp
	health_bar.value = hp

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
		
func on_destroy():
	sonido_puntos.play()
	is_dead = true
	get_node("KinematicBody2D").set_collision_layer_bit(0,false)
	get_node("KinematicBody2D").set_collision_mask_bit(0,false)
	animated_sprite.play("death")
	get_node("HealthBar").visible = false

func _on_Enemigo_animation_finished():
	if is_dead:
		queue_free()
		Data.player["Player"]["score"] += Data.enemigos[enemy_name]["score"]
		
