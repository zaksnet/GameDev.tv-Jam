extends KinematicBody2D

var speed = 750
var explosion = preload("res://Blaster/Explosion.tscn")
var damage = 30
var charge_level = 1
var velocity = Vector2()

func start(pos, dir):
	rotation = dir
	position = pos
	velocity = Vector2(speed, 0).rotated(rotation)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	
	if collision and collision.collider.name != "Player":
		# Make sure we only collide once with the same object
		add_collision_exception_with(collision.collider)
		
		var inst = explosion.instance()
		inst.global_position = global_position
		collision.collider.get_parent().add_child(inst)
		if charge_level <= 1:
			queue_free()
		else:
			charge_level -= 1
#		velocity = velocity.bounce(collision.normal)
		if collision.collider.has_method("take_damage"):
			collision.collider.take_damage(rotation, damage)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
