extends Node2D

var spell = preload("res://Scenes/Projectiles/Semilla.tscn")
var mover = false	
var pos_actual = self.position
var is_atacking = false
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
	get_node("Torre").look_at(enemy.position)
	print(animated_sprite.get_rotation_degrees())
	if 90<animated_sprite.get_rotation_degrees() and animated_sprite.get_rotation_degrees()<270:
		if animated_sprite.is_flipped_v() == false:
			animated_sprite.flip_v = true
			
		if ready == false:
			animated_sprite.play("attack_right")
		else:
			animated_sprite.play("idle")
	elif -90<animated_sprite.get_rotation_degrees() and animated_sprite.get_rotation_degrees()<90:
		if animated_sprite.is_flipped_v() == true:
			animated_sprite.flip_v = false
		if ready == false:
			animated_sprite.play("attack_right")
		else:
			animated_sprite.play("idle")
	else: 
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
	if is_atacking == false:
		animated_sprite.play("idle")
		animated_sprite.set_rotation_degrees(0)
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
	is_atacking = false
