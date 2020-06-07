extends Node

onready var levels = [
	preload("res://Levels/Level1.tscn")
]

enum levels_enum {
	LEVEL1,
	LEVEL2
}

var player
var explosion
var mainScene

func _enter_tree():
	player = preload("res://Player/Player.tscn")
	explosion = preload("res://Weapons/PlasmaCannon/Explosion.tscn")
	mainScene = preload("res://MainScene.tscn")
