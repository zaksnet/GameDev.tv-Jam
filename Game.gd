extends Node


func _ready():
	$MusicIntro.play()
	pass

func _on_MusicIntro_finished():
	$MusicLoop.play()

func _on_Button_pressed():
	$MusicLoop.stop()
	$MusicIntro.stop()
	get_tree().change_scene("res://Level1.tscn")
