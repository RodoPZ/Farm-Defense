extends Node2D

var spell = preload("res://Scenes/Projectiles/Semilla.tscn")
var mover = false	
var pos_actual = self.position
var rot_actual
var is_attacking
var type
var enemy_array = []
var built = false
var enemy
var ready = true


#var nombre = ""
onready var animated_sprite : AnimatedSprite = get_node("Torre")
#Comenté connect porque daba errores rodo (junto con todo el ready)
#func _ready():
#	connect("", self, "signal")

func _ready():
	if built:
		self.get_node("Rango/CollisionShape2D").get_shape().extents = 8*Vector2(Data.tower_data[type]["range"],Data.tower_data[type]["range"])
		animated_sprite.speed_scale = Data.tower_data[type]["rof"]


##
## Rotación de sprites
#Si se usa delta quitar undescore
func _physics_process(_delta):
	if enemy_array.size() != 0 and built:
		select_enemy()
		turn()
		if ready:
			fire()
	else:
		enemy = null

func turn():
	#get_node("Torre").look_at(enemy.position)
	get_node("Torre").look_at(get_global_mouse_position())
	animate()

	

	"""
	if 	not animated_sprite.flip_v and not animated_sprite.flip_h:
		print("arriba")
	elif animated_sprite.flip_v and not animated_sprite.flip_h:
		print("izq")
	elif not animated_sprite.flip_v and animated_sprite.flip_h:
		print("izq")
	"""
	#if is_attacking == false and ready == false:
		#is_attacking = true
		#if (rot_actual > 45 and rot_actual < 135) or (rot_actual > -315 and rot_actual < -225):
		#print(rot_actual)
			#print("abajo")
#		if is_attacking == false:
#			is_attacking = true
			#animated_sprite.play("attack_down")
		#elif (rot_actual > 135 and rot_actual < 225) or (rot_actual > -225 and rot_actual < -135):
		#print(rot_actual)
			#print("izquierda")
			#animated_sprite.flip_h = true
#		if is_attacking == false:
#			is_attacking = true
			#animated_sprite.play("attack_right")
		#elif (rot_actual > 225 and rot_actual < 315) or (rot_actual > -135 and rot_actual < -45):
		#print(rot_actual)
			#print("arriba")
#		if is_attacking == false:
#			is_attacking = true
			#animated_sprite.play("attack_down")
		#elif (rot_actual > 315 or rot_actual < 45) or (rot_actual > -45 or rot_actual < -315):
		#print(rot_actual)
			#print("derecha")
#		if is_attacking == false:
#			is_attacking = true
			#animated_sprite.flip_h = false
			#animated_sprite.play("attack_right")
func animate():
	#(	fmod(animated_sprite.get_rotation_degrees(),360))
	if ready == false:
		is_attacking = true
		if 45<animated_sprite.get_rotation_degrees() and animated_sprite.get_rotation_degrees()<135:
			animated_sprite.play("attack_down")
			if animated_sprite.is_flipped_v() == true:
				animated_sprite.flip_v = false
		elif 135 < animated_sprite.get_rotation_degrees() and animated_sprite.get_rotation_degrees() < 225:
			animated_sprite.play("attack_right")
			if animated_sprite.is_flipped_v() == false:
				animated_sprite.flip_v = true
		if -135<animated_sprite.get_rotation_degrees() and animated_sprite.get_rotation_degrees()<-45:
			animated_sprite.play("attack_up")
			if animated_sprite.is_flipped_v() == true:
				animated_sprite.flip_v = false
		elif -45<animated_sprite.get_rotation_degrees() and animated_sprite.get_rotation_degrees()<45:
			animated_sprite.play("attack_right")
			if animated_sprite.is_flipped_v() == true:
				animated_sprite.flip_v = false	
		else:
			if animated_sprite.is_flipped_v() == true:
				animated_sprite.flip_v = false	 
	else:
		animated_sprite.play("idle")




func select_enemy():
	var enemy_progress_array = []
	for i in enemy_array:
		enemy_progress_array.append(i.offset)
	var max_offset = enemy_progress_array.max()
	var enemy_index = enemy_progress_array.find(max_offset)
	enemy = enemy_array[enemy_index]


func fire():
	ready = false
	var spell_instance = spell.instance()
	spell_instance.init(enemy_array[0],type)
	spell_instance.position = get_node("Torre/Position2D").get_global_position()
	spell_instance.rotation = get_angle_to(enemy.position)
	get_parent().get_parent().add_child(spell_instance)
	yield(get_tree().create_timer(Data.tower_data[type]["rof"]), "timeout")
	ready = true


# si body se usa quitar el underscore
func _on_Rango_body_entered(body):
	enemy_array.append(body.get_parent())
	mover = true
	
func _on_Rango_body_exited(body):
	enemy_array.erase(body.get_parent())
	mover = false
	animated_sprite.set_rotation_degrees(0)
	if is_attacking == false:
		animated_sprite.play("idle")
	if animated_sprite.is_flipped_v() == true:
		animated_sprite.flip_v = false


"""
func _on_Derecha_body_entered(_body):
	if anim_free == true:
		anim_free = false
		animated_sprite.flip_h = false
		animated_sprite.play("attack_right")
func _on_Abajo_body_entered(_body):
	if anim_free == true:
		anim_free = false
		animated_sprite.play("attack_down")
func _on_Izquierda_body_entered(_body):
	if anim_free == true:
		anim_free = false
		animated_sprite.flip_h = true
		animated_sprite.play("attack_right")
func _on_Arriba_body_entered(_body):
	if anim_free == true:
		anim_free = false
		animated_sprite.play("attack_up")
"""

func _on_Torre_animation_finished():
		is_attacking = false
