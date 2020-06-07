extends Node
var zombie = preload("res://Scenes/Zombie/Enemy.tscn")
var grass = preload("res://Scenes/Grass/Grass.tscn")
var tree1 = preload("res://Assets/Trees/Tree1.tscn")

# This indicates which weapons can be used in this level
onready var level_weapons = {
	"PlasmaCannon": WeaponResources.plasma_cannon
}

var starting_weapon = WeaponResources.weapons.plasma_cannon
var level_timer = 300

signal player_instance
signal level_win
signal level_lose
signal camera_shake

var player: Player
# Game play code should not be in this file...

func _ready():
	player = ResourceManager.player.instance()
	$YSort.add_child(player)
	call_deferred("emit_signal","player_instance", player)
	# We keep the boss as "level" asset for now.
	$Boss.connect("spawn_zombies", self, "spawn_zombies")
	$Boss.connect("camera_shake", self, "camera_shake")
	generate_grass()
	generate_trees()
	generate_zombies()
	$StageMusic.play()
	
	
func _exit_tree():
	emit_signal("player_instance", null)


func generate_zombies():
	var map_range = Vector2(10000, -10000)

	for x in 1000:
		var inst = zombie.instance()
		randomize()
		var rnd = rand_range(map_range.x, map_range.y)
		inst.playerNode = player
		inst.position.x = rand_range(map_range.x, map_range.y)
		inst.position.y = rand_range(map_range.x, map_range.y)
		$YSort.add_child(inst)

func generate_grass():
	# Generates random grass
	var map_range = Vector2(10000, -10000)

	for x in 2000:
		var inst = grass.instance()
		randomize()
		var rnd = rand_range(map_range.x, map_range.y)
		inst.position.x = rand_range(map_range.x, map_range.y)
		inst.position.y = rand_range(map_range.x, map_range.y)
		$YSort.add_child(inst)


func generate_trees():
	var map_range = Vector2(10000, -10000)

	for x in 500:
		var inst = tree1.instance()
		randomize()
		var rnd = rand_range(map_range.x, map_range.y)
		inst.position.x = rand_range(map_range.x, map_range.y)
		inst.position.y = rand_range(map_range.x, map_range.y)
		$YSort.add_child(inst)


func camera_shake():
	# TODO: Fix this
	emit_signal("camera_shake")


func spawn_zombies():
	var grp = get_node("Zombies")
	var player_pos = player.position
	var rnd = rand_range(10, 25)
	for x in rnd:
		var inst = zombie.instance()
		inst.playerNode = player
		inst.init_state = "Attack"
		inst.position.x = rand_range(player_pos.x - 500, player_pos.x + 500)
		inst.position.y = rand_range(player_pos.y - 500, player_pos.y + 500)
		grp.add_child(inst)


func _on_Restart_pressed():
	get_tree().paused = false
	$UI/GameOverScreen/GameOverMusic.stop()
	get_tree().reload_current_scene()


func _on_Area2D_body_entered(body):
	# TODO: Check the body name in case some stray zombie spawns in there?
	# TODO: Should also check if the boss is dead? No time
	if body.name == "Player":
		emit_signal("level_win")
