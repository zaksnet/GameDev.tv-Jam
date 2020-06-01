extends State

func on_enter(target: Boss):
	target.show_health()
	target.disable_wakeup()
	target.play_anim("WakeUp")
	target.connect("animation_finished", self, "animation_finished")
	print("Boss Attack state")


func animation_finished():
	go_to("Attack")
	
func on_exit(target: Boss):
	target.disconnect("animation_finished", self, "animation_finished")
