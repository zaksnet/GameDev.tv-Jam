extends State


func on_timers_register() -> void:
	register_timer('go_to Idle', 1.5)


func on_enter(target: Player) -> void:
	target.play_anim('thumbs_up')


func on_physics_process(target: Player, delta: float) -> void:
	target.direction = 0
	target.move_player()
