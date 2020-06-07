extends State

var trg: Enemy

func on_enter(target: Enemy):
	trg = target
	target.play_anim("Idle")
	print("Follow state")


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		go_to("Attack")
