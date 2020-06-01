extends State
# This should only play once

func on_enter(target: Boss):
	target.hide_health()
	target.play_anim("Sleeping")
	print("Boss Sleeping state")
	
func on_physics_process(target: Boss, delta:float):
	pass

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		go_to("WakeUp")
