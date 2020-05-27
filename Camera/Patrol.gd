extends State


func on_enter(target: GameCamera) -> void:
	# TODO: Play idle animation
	print("Entered patrol state")
	target.draw_color = Color(1.0, 0.5, 0.0, 0.5)
	target.connect("body_entered", self, "player_entered_area")
	target.resume_moving()
	
func on_exit(target: GameCamera) -> void:
	print("Exited patrol state")
	
	target.disconnect("body_entered", self, "player_entered_area")
	target.stop_moving()
	
func player_entered_area():
	go_to("Alert")


func on_physics_process(target: GameCamera, delta: float) -> void:
	target.update()
