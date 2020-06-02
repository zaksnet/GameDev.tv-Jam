extends State

func on_enter(target: Enemy):
	print("Attack back state")
	target.play_growl()
	target.play_anim("Chase")
	pass

func on_physics_process(target: Enemy, delta:float):
	if !target.took_damage:
		target.move_and_attack(delta)
	else:
		go_to("PushBack")
