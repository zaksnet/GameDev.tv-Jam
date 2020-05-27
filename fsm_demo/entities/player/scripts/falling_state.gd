extends State


func on_enter(target: Player) -> void:
	target.play_anim('jump')


func on_physics_process(target: Player, delta: float) -> void:
	target.update_direction()
	target.move_player()

	if target.motion.y > 0:
		target.play_anim('fall')

	if target.is_on_floor():
		go_to('Landing')
