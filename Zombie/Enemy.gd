extends KinematicBody2D

class_name Enemy

var health = 100
var parent
var took_damage
var can_attack = true
var init_state = ""

var speed = 200

onready var playerNode = get_node("/root/Level1/Player")

var velocity = Vector2()


var growls = [
	preload("res://Assets/SFX/sfx_zombie_growl_01.wav"),
	preload("res://Assets/SFX/sfx_zombie_growl_02.wav"),
	preload("res://Assets/SFX/sfx_zombie_growl_03.wav")
]

func play_growl():
	var rnd = rand_range(0, 3)
	$AudioStreamPlayer2D.stream = growls[rnd]
	$AudioStreamPlayer2D.play()
	
func play_anim(pAnim):
	$AnimationPlayer.play(pAnim)

func _ready():
	if init_state != "":
		$FSM.go_to(init_state)
		
	check_health()
	set_speed()
	
func set_speed():
	speed = 50 #rand_range(50, 200)
	

func take_damage(rot, dmg):
	# TODO: We should probably pass the damage type and have custom damage factor for each damage type.
	$Tween.interpolate_property($AnimationPlayer, "modulate", Color(1, 0, 0), Color(1, 1 , 1), 1, Tween.TRANS_SINE, Tween.EASE_OUT)
	$Tween.start()
	took_damage = rot
	health -= dmg
	check_health()
	
	
func check_health():
	
	if health == 100:
		$HealthIndicator.visible = false
	else:
		$HealthIndicator.visible = true
		# TODO: Should propably take the sprite width instead of hardcoded
		$HealthIndicator.rect_size.x = 40 * health / 100
	if health <= 0:
		die()
		
		
func die():
	queue_free()

	
func push_back(rot):
	#look_at(playerNode.position)
	
	velocity = Vector2(1000,  0).rotated(rot)
	velocity = move_and_slide(velocity)


func move_and_attack(delta):
	# look_at(playerNode.position)
	
	velocity = position.direction_to(playerNode.position).normalized() * speed

	if position.distance_to(playerNode.position) > 20:
		# TODO: * Delta?
		var col = move_and_collide(velocity * delta)
		if col and col.collider.name == "Player":
			if can_attack:
				attack()
#	else:
#		if can_attack:
#			attack()
		
func attack():
	can_attack = false
	playerNode.take_damage()
	$Timer.start(2) # Can only attack every 2 seconds

func _on_Timer_timeout():
	can_attack = true
