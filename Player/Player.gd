extends KinematicBody2D

class_name Player

export (int) var speed = 200
export (int) var life = 3
var damage_factor = 5
var sprint = false
signal damage_taken

var velocity = Vector2()

func camera_shake(duration, frequency, amplitude):
	$Camera2D.shake(duration, frequency, amplitude)

func take_damage():
	$Tween.interpolate_property($AnimatedSprite, "modulate", Color(1, 0, 0), Color(1, 1, 1), 1, Tween.TRANS_SINE, Tween.EASE_OUT)
	$Tween.start()
	life -= 1
	emit_signal("damage_taken", life)

func get_input():
	velocity = Vector2()
	sprint = false
	var run_speed = speed
	# TODO: hacky, bad practice. Propably a waste of resources. Should instead use states
	

	if Input.is_action_pressed("Sprint"):
		run_speed = speed * 2
		sprint = true
		
	if Input.is_action_pressed('ui_right'):
		#$AnimatedSprite.flip_h = true

		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		#$AnimatedSprite.flip_h = false
		
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	velocity = velocity.normalized() * run_speed
	
	if velocity.x || velocity.y > 0 || velocity.y < 0:
		if !sprint:
			if Input.is_action_pressed('ui_right'):
				$AnimatedSprite.play("run", !$AnimatedSprite.flip_h)
			else:
				$AnimatedSprite.play("run", $AnimatedSprite.flip_h)
		else:
			if Input.is_action_pressed('ui_right'):
				$AnimatedSprite.play("sprint", !$AnimatedSprite.flip_h)
			else:
				$AnimatedSprite.play("sprint", $AnimatedSprite.flip_h)
			

	else:
		$AnimatedSprite.play("idle")

func set_flip_h(pValue):
	$AnimatedSprite.flip_h = pValue

func _physics_process(delta):

	get_input()
	velocity = move_and_slide(velocity)
	
	
	
var footsteps = [
	preload("res://Assets/Footsteps/sfx_playerfootsteps_01.mp3.wav"),
	preload("res://Assets/Footsteps/sfx_playerfootsteps_02.mp3.wav"),
	preload("res://Assets/Footsteps/sfx_playerfootsteps_03.mp3.wav"),
	preload("res://Assets/Footsteps/sfx_playerfootsteps_04.mp3.wav"),
	preload("res://Assets/Footsteps/sfx_playerfootsteps_05.mp3.wav"),
	preload("res://Assets/Footsteps/sfx_playerfootsteps_06.mp3.wav"),
	preload("res://Assets/Footsteps/sfx_playerfootsteps_07.mp3.wav"),
	preload("res://Assets/Footsteps/sfx_playerfootsteps_08.mp3.wav"),
	preload("res://Assets/Footsteps/sfx_playerfootsteps_09.mp3.wav"),
	preload("res://Assets/Footsteps/sfx_playerfootsteps_10.mp3.wav"),
	preload("res://Assets/Footsteps/sfx_playerfootsteps_11.mp3.wav"),
	preload("res://Assets/Footsteps/sfx_playerfootsteps_12.mp3.wav"),
	preload("res://Assets/Footsteps/sfx_playerfootsteps_13.mp3.wav")
]

func _on_AnimatedSprite_frame_changed():
	var cur_anim = $AnimatedSprite.animation
	var frame = $AnimatedSprite.frame
	if cur_anim == "run":
		if frame == 4 || frame == 0:
			$AudioStreamPlayer2D.stream = footsteps[rand_range(0, 12)]
			$AudioStreamPlayer2D.play()
	elif cur_anim == "sprint":
		if frame == 0 || frame == 10:
			$AudioStreamPlayer2D.play()
