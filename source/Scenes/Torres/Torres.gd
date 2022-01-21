extends Node2D

var spell = preload("res://Scenes/Projectiles/Semilla.tscn")
var rot_actual
var type
var enemy_array = []
var built = false
var enemy
var ready = true
var atack_anim = true

onready var animated_sprite : AnimatedSprite = get_node("Torre")
onready var attack_sound : AudioStreamPlayer = get_node("SoundAttack")

func _ready():
	if built:
		self.get_node("Rango/CollisionShape2D").get_shape().extents = 8*Vector2(Data.tower_data[type]["range"],Data.tower_data[type]["range"])
		animated_sprite.speed_scale = 2

func _physics_process(_delta):
	if enemy_array.size() != 0 and built:
		select_enemy()
		turn()
		if ready:
			fire()
	else:
		animate_idle()
		enemy = null
		
func turn():
	get_node("Torre").look_at(enemy.position)
	animate()

func animate():
	rot_actual = fmod(animated_sprite.get_rotation_degrees(),360)
	if ready == false:
		atack_anim = true
		if (45<rot_actual and rot_actual<135) or (-315<rot_actual and rot_actual <-225):
			animated_sprite.play("attack_down")
			if animated_sprite.is_flipped_v() == true:
				animated_sprite.flip_v = false
		elif (135 < rot_actual and rot_actual < 225) or ( -225 <rot_actual and rot_actual <-135):
			animated_sprite.play("attack_right")
			if animated_sprite.is_flipped_v() == false:
				animated_sprite.flip_v = true
		elif (225<rot_actual and rot_actual<315) or ( -135 <rot_actual and rot_actual <-45):
			animated_sprite.play("attack_up")
			if animated_sprite.is_flipped_v() == true:
				animated_sprite.flip_v = false
		else: 
			animated_sprite.play("attack_right")
			if animated_sprite.is_flipped_v() == true:
				animated_sprite.flip_v = false	
	else: 
		animate_idle()

func animate_idle():
	animated_sprite.set_rotation_degrees(0)
	animated_sprite.play("idle")
	if animated_sprite.is_flipped_v() == true:
		animated_sprite.flip_v = false
		
func select_enemy():
	var enemy_progress_array = []
	for i in enemy_array:
		enemy_progress_array.append(i.offset)
	var max_offset = enemy_progress_array.max()
	var enemy_index = enemy_progress_array.find(max_offset)
	enemy = enemy_array[enemy_index]

func fire():
	ready = false
	attack_sound.play()
	var spell_instance = spell.instance()
	spell_instance.init(enemy_array[0],type)
	spell_instance.position = get_node("Torre/Position2D").get_global_position()
	spell_instance.rotation = get_angle_to(enemy.position)
	get_parent().get_parent().add_child(spell_instance)
	yield(get_tree().create_timer(Data.tower_data[type]["rof"]), "timeout")
	ready = true
	
func _on_Rango_body_entered(body):
	enemy_array.append(body.get_parent())
	
func _on_Rango_body_exited(body):
	enemy_array.erase(body.get_parent())
