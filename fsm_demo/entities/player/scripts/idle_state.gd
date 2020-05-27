extends State


func on_enter(target: Player) -> void:
	target.play_anim('idle')


func on_physics_process(target: Player, delta: float) -> void:
	if Input.is_action_pressed('ui_up'):
		go_to('Jumping')

	target.update_direction()
	target.move_player()

	if target.direction:
		go_to('Running')

	elif not target.is_on_floor():
		go_to('Falling')
