extends Node

class_name WeaponsService

onready var plasmaCannon = WeaponResources.plasma_cannon
var player_instance

var current_weapon = null

func _ready():
	pass # Replace with function body.

func set_player_instance(pInstance):
	if pInstance != null:
		player_instance = pInstance
	else:
		# Delete current weapon
		set_current_weapon()

# TODO: Enums cant be used as types?
func set_current_weapon(pWeapon = WeaponResources.weapons.empty):
	$FSM.go_to(WeaponResources.weapon_states[pWeapon])
