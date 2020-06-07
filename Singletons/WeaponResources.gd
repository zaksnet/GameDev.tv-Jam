extends Node

onready var plasma_cannon = preload("res://Weapons/PlasmaCannon/PlasmaCannon.tscn")
onready var grenade # TODO: Implement
onready var bazooka # TODO: Implement


var weapon_states: PoolStringArray = [
	"Empty",
	"PlasmaCannon",
	"Bazooka",
]

enum weapons {
	empty,
	plasma_cannon,
	bazooka,
}
