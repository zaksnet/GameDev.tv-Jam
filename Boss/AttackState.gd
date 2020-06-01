extends State

func on_enter(target: Boss):
	target.connect("animation_finished", self, "animation_finished")
	target.play_anim("Attack")
	print("Boss Attack state")
	
func animation_finished():
	target.spawn_zombies()
	go_to("Idle")

func on_exit(target: Boss):
	target.disconnect("animation_finished", self, "animation_finished")
