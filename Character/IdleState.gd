extends State


func on_enter(target: Character) -> void:
	# TODO: Play idle animation
	print("Entered idle state")


func on_physics_process(target: Character, delta: float) -> void:
	if Input.is_action_pressed('ui_up'):
		# TODO: Rotate sprite to look up
		pass
		
	if Input.is_action_pressed("Attack"):
		go_to("Attacking")

	# target.update_direction()


	if Input.is_action_pressed("ui_left") or \
		Input.is_action_pressed("ui_right") or \
		Input.is_action_pressed("ui_up") or \
		Input.is_action_pressed("ui_down"):
		go_to('Running')
