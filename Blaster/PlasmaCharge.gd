extends Node2D

var charging_timer = 5
var charge_level = 0

func _ready():
	$Timer.start(charging_timer)

func _process(delta):
	# TODO: This should propably not be handled here. If we increase the charging time then this should be adjusted also
	if not $Timer.is_stopped():
		if $Timer.time_left > 4.5:
			# Charge level 1
			charge_level = 1
			$Sprite.scale = Vector2(0.5, 0.5)
		elif $Timer.time_left > 4:
			# Charge level 2
			charge_level = 2
			$Sprite.scale = Vector2(1, 1)
		elif $Timer.time_left > 3.5:
			# Charge level 3
			charge_level = 3
			
			$Sprite.scale = Vector2(1.5, 1.5)
		elif $Timer.time_left > 3:
			# Charge level 4
			charge_level = 4
			$Sprite.scale = Vector2(2, 2)

			
