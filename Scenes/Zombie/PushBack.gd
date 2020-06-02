extends State


func on_enter(target: Enemy):
	print("Push back state")
	target.push_back(target.took_damage)

	
func on_physics_process(target: Enemy, delta: float):
	if target.position.distance_to(target.playerNode.position) >= 70:
		go_to("Attack")
		target.took_damage = false
	else:
		target.push_back(target.took_damage)

