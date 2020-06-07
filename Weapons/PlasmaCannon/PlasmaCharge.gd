extends Node2D

var charging_timer = 5
var charge_level: int = 0

# I tried changing the stream of one audioplayer but that did not work (?)
var charge_sfx = [
	preload("res://Assets/Blaster/Charging/00 - plasmacharge - sfx plasmacharge level1.ogg"),
	preload("res://Assets/Blaster/Charging/00 - plasmacharge - sfx plasmacharge level2.ogg"),
	preload("res://Assets/Blaster/Charging/00 - plasmacharge - sfx plasmacharge level3.ogg"),
	preload("res://Assets/Blaster/Charging/00 - plasmacharge - sfx plasmacharge level4.ogg"),
]

func _ready():
	$Timer.start(charging_timer)

func _process(delta):
	# TODO: This should propably not be handled here. If we increase the charging time then this should be adjusted also
	if not $Timer.is_stopped():
		if $Timer.time_left > 4.5:
			# Charge level 1
			charge_level = 1
			$Sprite.scale = Vector2(0.5, 0.5)
			if not $level1.playing:
				player_charge_sfx(1)
		elif $Timer.time_left > 4:
			# Charge level 2
			charge_level = 2
			$Sprite.scale = Vector2(1, 1)
			if not $level2.playing:
				player_charge_sfx(2)

		elif $Timer.time_left > 3.5:
			# Charge level 3
			charge_level = 3
			$Sprite.scale = Vector2(1.5, 1.5)
			if not $level3.playing:
				player_charge_sfx(3)

		elif $Timer.time_left > 3:
			# Charge level 4
			charge_level = 4
			$Sprite.scale = Vector2(2, 2)
			if not $level4.playing:
				player_charge_sfx(4)



func player_charge_sfx(level):
	$level1.stop()
	$level2.stop()
	$level3.stop()
	$level4.stop()
	match level:
		1:
			$level1.play()
		2:
			$level2.play()
		3:
			$level3.play()
		4:
			$level4.play()
