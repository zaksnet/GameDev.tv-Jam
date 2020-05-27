extends Node

onready var playerTime = $CanvasLayer/UI/MarginContainer/Panel/PlayerTime

# TODO: This should instead be a class
var default_player_time: Dictionary = {
	years = 00,
	days = 00,
	hours = 01,
	minutes = 05,
	seconds = 00
}

var player_time: Dictionary = {
	years = 00,
	days = 00,
	hours = 00,
	minutes = 00,
	seconds = 00
}

func _ready():
	start_timer()
	pass # Replace with function body.



func start_timer():
	# TODO: Check if there is a save game file and load it. OTherwise, player time will be the default player time.
	
	player_time = default_player_time
	
	$Timer.connect("timeout", self, "timer_timeout")
	$Timer.autostart = true
	$Timer.start(1)
	set_player_time_text()
	
func timer_timeout():
	update_timer()
	set_player_time_text()
	
func add_time(pTime: Dictionary):
	pass
	
func update_timer():
	var years = player_time.years
	var days = player_time.days
	var hours = player_time.hours
	var minutes = player_time.minutes
	var seconds = player_time.seconds
	
	if seconds > 0:
		player_time.seconds -= 1
		return
	
	if minutes > 0:
		player_time.seconds = 60
		player_time.minutes -= 1
		return
	
	if hours > 0:
		player_time.seconds = 60
		player_time.minutes = 60
		player_time.hours -= 1
		return
	
	if days > 0:
		player_time.seconds = 60
		player_time.minutes = 60
		player_time.hours = 24
		player_time.days -= 1
		return
	

	if years > 0:
		player_time.seconds = 60
		player_time.minutes = 60
		player_time.hours = 24
		player_time.days = 365
		player_time.years -= 1
		return
		
	# If it got that far then the player lost?
		
	
	
	
func get_string(pInt: int):
	if pInt < 10:
		return "0" + str(pInt)
	else:
		return str(pInt)
		

	
func set_player_time_text():
	var player_time_string = ""

	player_time_string = get_string(player_time.years) + ":" + get_string(player_time.days) + ":" + get_string(player_time.hours) + ":" + get_string(player_time.minutes) + ":" + get_string(player_time.seconds)
	playerTime.text = player_time_string
	
	
	
	
	
