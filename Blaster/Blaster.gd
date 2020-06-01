extends Sprite

var Bullet = preload("res://Blaster/Bullet.tscn")
var plasma_charge = preload("res://Blaster/PlasmaCharge.tscn")
# Not the best way to handle multiple weapons, but... limited time!
var active = false
var active_charge
var charge_level

func _ready():
	pass # Replace with function body.
	
func shoot():
	# "Muzzle" is a Position2D placed at the barrel of the gun.
	var b = Bullet.instance()
	var rot = rotation
	var pos = $BulletPoint.global_position
	b.charge_level = charge_level
	b.scale = Vector2(charge_level, charge_level)
	b.damage = b.damage * charge_level
	
	b.start(pos , rot)
	get_parent().get_parent().add_child(b)
	$AudioStreamPlayer2D.play()

func _physics_process(delta):
	var pos = get_global_mouse_position()

	look_at(pos)
	if rotation_degrees > 360:
		rotation_degrees = 0
	if rotation_degrees < 0:
		rotation_degrees = 360
		
		
	if rotation_degrees < 280 and rotation_degrees > 80:
		flip_v = true
	else:
		flip_v = false
		
		
	if Input.is_action_just_pressed('attack') and !Input.is_action_pressed("Sprint"):

		active_charge = plasma_charge.instance()
		active_charge.position = $BulletPoint.position
		add_child(active_charge)
	
	if Input.is_action_just_released("attack") and active_charge and active_charge.charge_level:
		var time_elapsed = $PlasmaTimer.time_left
		charge_level = active_charge.charge_level
		active_charge.queue_free()
		active_charge = null
		shoot()
		print(time_elapsed)
