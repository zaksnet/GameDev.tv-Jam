extends Sprite

class_name PlasmaCannon

var Bullet = preload("res://Weapons/PlasmaCannon/PlasmaBullet.tscn")
# Not the best way to handle multiple weapons, but... limited time!
var active = false
var active_charge
var overburn_initial_pos
var player_instance

signal plasma_level

func overheat(pValue):
	$Overheat.playing = pValue

func shoot(charge_level):
	var b = Bullet.instance()
	var rot = rotation
	var pos = $BulletPoint.global_position
	b.charge_level = charge_level
	b.scale = Vector2(charge_level, charge_level)
	b.damage = b.damage * charge_level
	b.add_collision_exception_with(player_instance)
	b.start(pos , rot)
	get_parent().get_parent().add_child(b)
	$AudioStreamPlayer2D.play()
	
	
func _ready():
	overburn_initial_pos = $Overburn.rect_position
	
func _process(delta):
	if flip_v:
		$Overburn.rect_position.y = overburn_initial_pos.y + 70
	else:
		$Overburn.rect_position.y = overburn_initial_pos.y
		
		

func get_bullet_point():
	return $BulletPoint.position
	
func set_overburn(pValue):
	$Overburn/Green.rect_size.x = pValue
