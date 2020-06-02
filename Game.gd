extends Node

# TODO: QOL improvements (propably never going to happend. Unless there is enough interest xD)
# - Apply single responsibility principle
# - Use a better weapon system base on a state machine so that it is easily expandable
# - Add more tiles
# - Add more animations for the player/zombies

func _ready():
	$MusicIntro.play()
	pass

func _on_MusicIntro_finished():
	$MusicLoop.play()

func _on_Button_pressed():
	$MusicLoop.stop()
	$MusicIntro.stop()
	get_tree().change_scene_to(ResourceManager.level1)
