extends Node
onready var zombie = preload("res://Zombie/Enemy.tscn")
onready var grass = preload("res://Grass/Grass.tscn")
var game_over_time: float = 300

func _ready():
	$Boss.connect("spawn_zombies", self, "spawn_zombies")
	$Player.connect("damage_taken", self, "check_player_health")
	$Boss.connect("camera_shake", self, "camera_shake")

	$UI/GameOverScreen.visible = false
	reset_hearts()
	generate_grass()
	$StageMusic.play()
	
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
	
func win():
	$UI/GameOverScreen/HBoxContainer/GameOverLabel.text = "To be continued..."
	game_over()
	
func camera_shake():
	$Player/Camera2D.shake(1, 10, 10)

func _input(event):

	if event.is_action_pressed("zoom_in"):
		if $Player/Camera2D.zoom.x < 2:
			$Player/Camera2D.zoom.x += 0.1
			$Player/Camera2D.zoom.y += 0.1
	if event.is_action_pressed("zoom_out"):
		if $Player/Camera2D.zoom.x > 1:
			$Player/Camera2D.zoom -= Vector2(0.1, 0.1)
			
	if event.is_action_pressed("Sprint"):
		$UI/MarginContainer/VBoxContainer/PanelContainer2/SprintIndicator.pressed = true
	if event.is_action_released("Sprint"):
		$UI/MarginContainer/VBoxContainer/PanelContainer2/SprintIndicator.pressed = false
		
	if event.is_action_pressed("ui_left"):
		$UI/MarginContainer/VBoxContainer/HBoxContainer/left.pressed = true
	if event.is_action_released("ui_left"):
		$UI/MarginContainer/VBoxContainer/HBoxContainer/left.pressed = false
		
	if event.is_action_pressed("ui_right"):
		$UI/MarginContainer/VBoxContainer/HBoxContainer/Right.pressed = true
	if event.is_action_released("ui_right"):
		$UI/MarginContainer/VBoxContainer/HBoxContainer/Right.pressed = false
		
	if event.is_action_pressed("ui_up"):
		$UI/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Top.pressed = true
	if event.is_action_released("ui_up"):
		$UI/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Top.pressed = false

	if event.is_action_pressed("ui_down"):
		$UI/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Bottom.pressed = true
	if event.is_action_released("ui_down"):
		$UI/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Bottom.pressed = false

func _process(delta):
	check_player_health()
	
func check_player_health():
	var playerLife = $Player.life
	$UI/MarginContainer2/HBoxContainer/Heart1.modulate = Color(1, 1, 1, 1) if playerLife > 2 else Color(0, 0, 0, 1)
	$UI/MarginContainer2/HBoxContainer/Heart2.modulate = Color(1, 1, 1, 1) if playerLife > 1 else Color(0, 0, 0, 1)
	
	if playerLife <= 0:
		game_over()
		
func game_over():
	get_tree().paused = true
	$UI/GameOverScreen/GameOverMusic.play()
	$UI/GameOverScreen.visible = true
	
func reset_hearts():
	$UI/MarginContainer2/HBoxContainer/Heart1.modulate = Color(1, 1, 1, 1)
	$UI/MarginContainer2/HBoxContainer/Heart2.modulate = Color(1, 1, 1, 1)
	$UI/MarginContainer2/HBoxContainer/Heart3.modulate = Color(1, 1, 1, 1)
	
func spawn_zombies():
	var grp = get_node("Zombies")
	var player = get_node("Player")
	var player_pos = player.position
	var rnd = rand_range(10, 25)
	for x in rnd:
		var inst = zombie.instance()
		inst.init_state = "Attack"
		inst.position.x = rand_range(player_pos.x - 500, player_pos.x + 500)
		inst.position.y = rand_range(player_pos.y - 500, player_pos.y + 500)
		grp.add_child(inst)
		
		
func get_seconds(num):
	var whole = floor(num)
	var dec = num - whole
	return dec * 60


func _on_GameTimer_timeout():
	game_over_time -= 1
	var minutes: float = game_over_time / 60
	var seconds = get_seconds(minutes)
	$UI/PanelContainer/TimeLeft.text = str(floor(minutes)) + ":" + str(seconds)


func _on_Restart_pressed():
	get_tree().paused = false
	$UI/GameOverScreen/GameOverMusic.stop()
	get_tree().reload_current_scene()


func _on_Area2D_body_entered(body):
	# TODO: Check the body name in case some stray zombie spawns in there?
	# TODO: Should also check if the boss is dead? No time
	if body.name == "Player":
		win()
