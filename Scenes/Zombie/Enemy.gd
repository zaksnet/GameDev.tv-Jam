extends KinematicBody2D

class_name Enemy

var health = 100
var parent
var took_damage
var can_attack = true
var init_state = ""

var speed = 200

onready var playerNode = get_node("/root/Level1/Player")
onready var bloodSplat = preload("res://Scenes/Zombie/BloodSplat.tscn")
onready var zombieDieExplosion = preload("res://Scenes/Zombie/ZombieExplosion.tscn")

var velocity = Vector2()


var growls = [
	preload("res://Assets/Zombie/SFX/00 - zombies - sfx zombie growl 01.ogg"),
	preload("res://Assets/Zombie/SFX/00 - zombies - sfx zombie growl 02.ogg"),
	preload("res://Assets/Zombie/SFX/00 - zombies - sfx zombie growl 03.ogg"),
	preload("res://Assets/Zombie/SFX/00 - zombies - sfx zombie growl 04.ogg"),
	preload("res://Assets/Zombie/SFX/00 - zombies - sfx zombie growl 05.ogg"),
	preload("res://Assets/Zombie/SFX/00 - zombies - sfx zombie growl 06.ogg"),
	preload("res://Assets/Zombie/SFX/00 - zombies - sfx zombie growl 07.ogg"),
	preload("res://Assets/Zombie/SFX/00 - zombies - sfx zombie hiss 01.ogg"),
	preload("res://Assets/Zombie/SFX/00 - zombies - sfx zombie hiss 02.ogg"),
	preload("res://Assets/Zombie/SFX/00 - zombies - sfx zombie hiss 03.ogg"),
	preload("res://Assets/Zombie/SFX/00 - zombies - sfx zombie hiss 04.ogg"),
	preload("res://Assets/Zombie/SFX/00 - zombies - sfx zombie hiss 05.ogg"),
	preload("res://Assets/Zombie/SFX/00 - zombies - sfx zombie hiss 06.ogg"),
	preload("res://Assets/Zombie/SFX/00 - zombies - sfx zombie hiss 07.ogg"),
	preload("res://Assets/Zombie/SFX/00 - zombies - sfx zombie hiss 08.ogg"),
	preload("res://Assets/Zombie/SFX/00 - zombies - sfx zombie hiss 09.ogg"),
	preload("res://Assets/Zombie/SFX/00 - zombies - sfx zombie hiss 10.ogg"),
	preload("res://Assets/Zombie/SFX/00 - zombies - sfx zombie hiss 11.ogg"),
	preload("res://Assets/Zombie/SFX/00 - zombies - sfx zombie hiss 12.ogg"),
	preload("res://Assets/Zombie/SFX/00 - zombies - sfx zombie hiss 13.ogg"),
	preload("res://Assets/Zombie/SFX/00 - zombies - sfx zombie hiss 14.ogg"),
	preload("res://Assets/Zombie/SFX/00 - zombies - sfx zombie hiss 15.ogg"),
	preload("res://Assets/Zombie/SFX/00 - zombies - sfx zombie hiss 16.ogg"),
]

var zombieExplostions = [
	preload("res://Assets/Zombie/SFX/00 - zombie explosion - sfx zombieexplosion 01.ogg"),
	preload("res://Assets/Zombie/SFX/00 - zombie explosion - sfx zombieexplosion 02.ogg"),
	preload("res://Assets/Zombie/SFX/00 - zombie explosion - sfx zombieexplosion 03.ogg"),
]

func play_growl():
	var rnd = rand_range(0, growls.size())
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
	
	blood_splat(rot)
	took_damage = rot
	health -= dmg
	check_health()
	
func blood_splat(rot):
	var inst = bloodSplat.instance()
	inst.global_position = global_position
	inst.rot = rot
	get_tree().get_root().add_child(inst)
	
	
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
	var inst = zombieDieExplosion.instance()
	inst.stream = zombieExplostions[rand_range(0, zombieExplostions.size())]
	get_tree().get_root().add_child(inst)
	queue_free()

	
func push_back(rot):
	#look_at(playerNode.position)
	
	velocity = Vector2(3000,  0).rotated(rot)
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
