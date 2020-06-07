extends Node

var current_level = null
# We should implement save functionality and load the level from there
var default_level = ResourceManager.levels_enum.LEVEL1

var player: Player

func _ready():
	print(ResourceManager.levels_enum.LEVEL1)
	change_level(default_level)
	current_level.connect("player_instance", self, "_set_player_instance")
	current_level.connect("level_win", self, "show_win_screen")
	current_level.connect("level_lose", self, "show_lose_screen")
	current_level.connect("camera_shake", self, "camera_shake")
	$UI.connect("restart_level", self, "restart_level")
	

func camera_shake():
	player.camera_shake(1, 100, 10)
	
func _set_player_instance(pInstance):
	player = pInstance
	if pInstance != null:
		player.connect("damage_taken", self, "update_player_health")
		player.connect("damage_taken", $UI, "update_player_health")
		$WeaponsService.set_player_instance(pInstance)
		$WeaponsService.set_current_weapon(current_level.starting_weapon)
	else:
		$WeaponsService.set_player_instance(null)
		$WeaponsService.set_current_weapon()


func restart_level():
	get_tree().reload_current_scene()
	get_tree().paused = false
	
func change_level(pLevel):
	if !current_level == null:
		current_level.queue_free()
	current_level = ResourceManager.levels[pLevel].instance()
	add_child(current_level)


func show_win_screen():
	$UI/GameOverScreen/HBoxContainer/GameOverLabel.text = "To be continued..."
	show_game_over_screen()


func show_game_over_screen():
	get_tree().paused = true
	$UI/GameOverScreen/GameOverMusic.play()
	$UI/GameOverScreen.visible = true


func update_player_health(playerLife):
	# TODO: This should only be triggered with signals
	if playerLife <= 0:
		show_game_over_screen()
