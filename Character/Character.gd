extends KinematicBody2D

class_name Character

export var SPEED = 100
var velocity = Vector2()


func _ready():
	pass # Replace with function body.

func move_character():
	var is_left = Input.is_action_pressed("ui_left")
	var is_right = Input.is_action_pressed("ui_right")
	var is_top = Input.is_action_pressed("ui_up")
	var is_down = Input.is_action_pressed("ui_down")

	if is_left:
		velocity.x -= 1
		
	if is_right:
		velocity.x += 1
		
	if is_top:
		velocity.y -= 1
		
	if is_down:
		velocity.y += 1
		
	if velocity.x == 1 and velocity.y == 1:
		velocity = Vector2(0.5, 0.5)
		
	if velocity == Vector2.ZERO:
		# Play idle animation
		pass
		
	velocity = velocity.normalized() * SPEED

	velocity = move_and_slide(velocity)
	velocity = Vector2.ZERO
	


func _on_Area2D_area_entered(area):

	$GrabIndicator.visible = true
	
func _on_Area2D_area_exited(area):

	$GrabIndicator.visible = false
	

