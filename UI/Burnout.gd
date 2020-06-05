extends Control

func burnout():
	$Timer.start()


func _on_Timer_timeout():
	$OverburnLabel.visible = !$OverburnLabel.visible
