extends State

func on_enter(target: Character) -> void:
	# TODO: Play idle animation
	print("Entered Running state")


func on_physics_process(target: Character, delta: float) -> void:
	
	target.move_character()

	if !Input.is_action_pressed("ui_left") and \
		!Input.is_action_pressed("ui_right") and \
		!Input.is_action_pressed("ui_up") and \
		!Input.is_action_pressed("ui_down"):
		go_to('Idle')
