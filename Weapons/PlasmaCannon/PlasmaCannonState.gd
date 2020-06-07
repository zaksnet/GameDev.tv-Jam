extends State

var instance: PlasmaCannon
var plasma_charge = preload("res://Weapons/PlasmaCannon/PlasmaCharge.tscn")

var charge_level
var overcharge = 100
var charging = false
var active_charge


func on_enter(target: WeaponsService):
	instance = WeaponResources.plasma_cannon.instance()
	instance.player_instance = target.player_instance
	target.player_instance.add_child(instance)


func on_physics_process(target: WeaponsService, delta:float):
	check_sprint(target)
	var pos = instance.get_global_mouse_position()
	
	if overcharge < 100:
		overcharge += 20 * delta
	#print(overcharge)
	
	if charging and overcharge >= 100:
		charging = false
		instance.overheat(false)
		
		
	
	instance.look_at(pos)
	if instance.rotation_degrees > 360:
		instance.rotation_degrees = 0
	if instance.rotation_degrees < 0:
		instance.rotation_degrees = 360
		
		
	if instance.rotation_degrees < 280 and instance.rotation_degrees > 80:
		instance.flip_v = true
	else:
		instance.flip_v = false
		
	target.player_instance.set_flip_h(!instance.flip_v)

		
	if Input.is_action_just_pressed('attack') and !Input.is_action_pressed("Sprint") and not charging:
		active_charge = plasma_charge.instance()
		active_charge.position = instance.get_bullet_point()

		instance.add_child(active_charge)
		
	
	if Input.is_action_just_released("attack") and active_charge and active_charge.charge_level:
		charge_level = active_charge.charge_level
		active_charge.queue_free()
		active_charge = null
		instance.shoot(charge_level)
		overcharge -= 10
		if overcharge <= 0:
			instance.overheat(true)
			charging = true
			
	set_overburn_ui()
		
		

func set_overburn_ui():
	var overburn_level = overcharge
	# TODO: Replace static width
	var width = 68 * overburn_level / 100
	if width <= 0:
		width = 0
		charging = true

	instance.set_overburn(width)

	
func check_sprint(target):
	var sprint = target.player_instance.sprint
	if target.player_instance.velocity.x || target.player_instance.velocity.y > 0 || target.player_instance.velocity.y < 0:
		if !sprint:
			instance.visible = true
		else:
			instance.visible = false

func on_exit(target: WeaponsService):
	instance.queue_free()
	instance = null
