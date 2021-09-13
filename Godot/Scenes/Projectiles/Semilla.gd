extends KinematicBody2D

export (int) var speed = 50
var target = Vector2()
var velocity = Vector2()
var turret_type
var wr

func init(targetpos,type):
	target = targetpos
	turret_type = type
	wr = weakref(target)

func _physics_process(_delta):
	if (wr.get_ref()):
		velocity = position.direction_to(target.position) * speed
		look_at(target.position)
		if position.distance_to(target.position) > 5:
			velocity = move_and_slide(velocity)
	else:
		queue_free()		
		
func _on_Area2D_body_entered(_body):
	target.on_hit(Data.tower_data[turret_type]["damage"])
	queue_free()

