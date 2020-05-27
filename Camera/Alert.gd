extends State


func on_enter(target: GameCamera) -> void:
	# TODO: Play idle animation
	print("Entered alert state")
	target.connect("body_exited", self, "player_exited_area")
	target.draw_color = Color(1.0, 0.0, 0.0, 0.5)
	target.update()
	
func on_exit(target: GameCamera) -> void:
	print("Exited alert state")
	
	target.disconnect("body_exited", self, "player_exited_area")
	
func player_exited_area():
	go_to("Patrol")
