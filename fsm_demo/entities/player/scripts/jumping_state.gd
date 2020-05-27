extends State


func on_timers_register() -> void:
	register_timer('go_to Falling', 0.1)


func on_enter(target: Player) -> void:
	target.play_anim('jump')
	target.play_jump_sound()


func on_input(target: Player, event: InputEvent) -> void:
	if event.is_action_released('ui_up'):
		go_to('Falling')


func on_physics_process(target: Player, delta: float) -> void:
	target.update_direction()
	target.jump()

	if target.is_on_ceiling():
		go_to('Falling')
