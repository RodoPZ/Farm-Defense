extends Node2D
var mover = false	
var pos_actual = self.position
#var nombre = ""
onready var animated_sprite : AnimatedSprite = get_node("Torre")

func _ready():
	connect("", self, "signal")
	#nombre = name
	#animated_sprite = get_node(name)
	#print(name)

func _on_Rango_body_entered(body):
	mover = true
func _on_Rango_body_exited(body):
	mover = false

#func _physics_process(delta):
#	pos_actual = get_node("../Path/Esqueleto").get_position()
#	self.position.look_at(pos_actual)
	

func _on_Derecha_body_entered(body):
	print("Sprite_Derecha")
	animated_sprite.play("attack_right")
func _on_Abajo_body_entered(body):
	print("Sprite_Abajo")
	animated_sprite.play("attack_down")
func _on_Izquierda_body_entered(body):
	print("Sprite_Izquierda")
	animated_sprite.flip_h = true
	animated_sprite.play("attack_right")
func _on_Arriba_body_entered(body):
	print("Sprite_Arriba")
	animated_sprite.play("attack_up")
