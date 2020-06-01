extends KinematicBody2D

class_name Boss
# TODO: Super hacky, bad practice
onready var player: Player = get_node("/root/Level1/Player")
var health = 3000
# Bad practice, not scalelable. This should propably be different for each weapon.
signal animation_finished
signal spawn_zombies
signal camera_shake

func _ready():
	$AnimatedSprite.connect("animation_finished", self, "animation_finished")
	
func take_damage(rot, damage):
	if health <= 0:
		queue_free()
	if $Health.visible:
		health -= damage
		$Health.rect_size.x = 245 * health / 3000
	else:
		$FSM.go_to("WakeUp")

	
func spawn_zombies():
	emit_signal("spawn_zombies")

func hide_health():
	$Health.visible = false
	
func show_health():
	$Health.visible = true
	
func disable_wakeup():
	$Area2D.set_deferred("monitoring", false)
	
func start_timer():
	var rnd = round(rand_range(5, 20))
	print("Attacking again in " + str(rnd))
	$Timer.start(rnd)
	
func animation_finished():
	var anim = $AnimatedSprite.animation
	emit_signal("animation_finished")
	
func play_anim(pAnim):
	$AnimatedSprite.play(pAnim)
	if pAnim == "WakeUp":
		$WakeUp.play()

func _physics_process(delta):
	#$Eye.look_at(player.global_position)
	# set_eye_pos()
	if $AnimatedSprite.is_playing():
		if $AnimatedSprite.animation == "Attack":
			if $AnimatedSprite.frame == 9:
				$Attack.play()
				emit_signal("camera_shake")
	pass
	
# TODO: This is not used. 
func set_eye_pos():
	if $AnimatedSprite.animation == "Idle":
		# TODO: SUPER hacky! Fast workaround for the eye to be able to follow the animation and also be able to follow the player.
		var frame = $AnimatedSprite.frame
		print(str(frame) + str($Eye.position.y))
		if frame <= 5:
			$Eye.position.y = -(323 - $AnimatedSprite.frame)
		else:
			$Eye.position.y = -(314 + $AnimatedSprite.frame)


