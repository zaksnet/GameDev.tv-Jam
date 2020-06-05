extends Node2D

var shape_scale = 1
var damage = 60

func _ready():
	var shape: CircleShape2D = $Area2D/CollisionShape2D.shape
	shape.radius = shape.radius * shape_scale
	


func _on_Area2D_body_entered(body: Node):
	if body.has_method("take_damage"):
		body.take_damage(rotation, damage)
		pass
