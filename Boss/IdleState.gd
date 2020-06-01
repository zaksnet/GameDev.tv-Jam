extends State

func on_enter(target: Boss):
	target.start_timer()
	target.play_anim("Idle")
	print("Boss Idle state")
	
func on_physics_process(target: Boss, delta:float):
	pass

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		go_to("Attack")


func _on_Timer_timeout():
	go_to("Attack")
