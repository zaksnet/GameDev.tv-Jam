extends AudioStreamPlayer2D

func _ready():
	pass # Replace with function body.


func _on_ZombieExpotion_finished():
	queue_free()
