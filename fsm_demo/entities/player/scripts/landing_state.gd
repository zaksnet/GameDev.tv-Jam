extends State


func on_enter(target: Player) -> void:
	target.play_anim('land')


func on_physics_process(target: Player, delta: float) -> void:
	if Input.is_action_pressed('ui_up'):
		go_to('Jumping')

	target.update_direction()
	target.move_player()


func _on_Sprite_animation_finished():
	if is_active_state():
		go_to('Idle')
