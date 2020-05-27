extends KinematicBody2D

class_name Player

const SPEED := 100
const JUMP_FORCE := 60
const GRAVITY := 600
const FLOOR_NORMAL := Vector2(0, -1)
const DEFAULT_FALL_SPEED := 0.1

var direction: int = 0
var motion: Vector2 = Vector2(0, DEFAULT_FALL_SPEED)

onready var fsm: FSM = $FSM as FSM
onready var jump_audio_player: AudioStreamPlayer = $JumpPlayer as AudioStreamPlayer


func play_anim(name: String) -> void:
	($Sprite as AnimatedSprite).play(name)


func play_jump_sound() -> void:
	jump_audio_player.play()


func get_direction() -> int:
	var direction: int = 0

	if Input.is_action_pressed('ui_right'):
		direction += 1

	if Input.is_action_pressed('ui_left'):
		direction -= 1

	return direction


func update_direction() -> void:
	direction = get_direction()

	if direction:
		($Sprite as AnimatedSprite).flip_h = direction < 0


func get_motion() -> Vector2:
	motion.x = lerp(motion.x, direction * SPEED, 0.5)
	return motion


func move_player() -> void:
	move_and_slide(get_motion(), FLOOR_NORMAL)


func jump() -> void:
	if motion.y > DEFAULT_FALL_SPEED:
		motion.y = -JUMP_FORCE
	else:
		motion.y += -JUMP_FORCE
	move_and_slide(get_motion(), FLOOR_NORMAL)


func _physics_process(delta: float) -> void:
	if is_on_floor() or is_on_ceiling():
		motion.y = DEFAULT_FALL_SPEED
	motion.y += delta * GRAVITY


func _on_Game_game_completed() -> void:
	fsm.go_to('Win')
