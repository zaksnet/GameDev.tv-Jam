extends CanvasLayer

var game_over_time: float = 300
signal restart_level

func _ready():
	reset_hearts()
	$GameOverScreen.visible = false
	
	
func update_player_health(playerHealth):
	$MarginContainer2/VBoxContainer/HBoxContainer/Heart1.modulate = Color(1, 1, 1, 1) if playerHealth > 2 else Color(0, 0, 0, 1)
	$MarginContainer2/VBoxContainer/HBoxContainer/Heart2.modulate = Color(1, 1, 1, 1) if playerHealth > 1 else Color(0, 0, 0, 1)


func reset_hearts():
	$MarginContainer2/VBoxContainer/HBoxContainer/Heart1.modulate = Color(1, 1, 1, 1)
	$MarginContainer2/VBoxContainer/HBoxContainer/Heart2.modulate = Color(1, 1, 1, 1)
	$MarginContainer2/VBoxContainer/HBoxContainer/Heart3.modulate = Color(1, 1, 1, 1)


func get_seconds(num):
	var whole = floor(num)
	var dec = num - whole
	return dec * 60


func _on_GameTimer_timeout():
	game_over_time -= 1
	var minutes: float = game_over_time / 60
	var seconds = get_seconds(minutes)
	$PanelContainer/TimeLeft.text = str(floor(minutes)) + ":" + str(seconds)
	
	
# Input related to UI
func _input(event):

	if event.is_action_pressed("Sprint"):
		$MarginContainer/VBoxContainer/PanelContainer2/SprintIndicator.pressed = true
	if event.is_action_released("Sprint"):
		$MarginContainer/VBoxContainer/PanelContainer2/SprintIndicator.pressed = false
		
	if event.is_action_pressed("ui_left"):
		$MarginContainer/VBoxContainer/HBoxContainer/left.pressed = true
	if event.is_action_released("ui_left"):
		$MarginContainer/VBoxContainer/HBoxContainer/left.pressed = false
		
	if event.is_action_pressed("ui_right"):
		$MarginContainer/VBoxContainer/HBoxContainer/Right.pressed = true
	if event.is_action_released("ui_right"):
		$MarginContainer/VBoxContainer/HBoxContainer/Right.pressed = false
		
	if event.is_action_pressed("ui_up"):
		$MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Top.pressed = true
	if event.is_action_released("ui_up"):
		$MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Top.pressed = false

	if event.is_action_pressed("ui_down"):
		$MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Bottom.pressed = true
	if event.is_action_released("ui_down"):
		$MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Bottom.pressed = false


func _on_Restart_pressed():
	emit_signal("restart_level")
