extends Node

# TODO: QOL improvements (propably never going to happend. Unless there is enough interest xD)
# - Apply single responsibility principle
# - Use a better weapon system base on a state machine so that it is easily expandable
# - Add more tiles
# - Add more animations for the player/zombies

func _ready():
	$MusicIntro.play()
	$Node2D/Loop.visible = false
	$Node2D/Main.frame = 0
	$Node2D/Main.visible = true
	$Node2D/Main.play()
	pass

func _on_MusicIntro_finished():
	$MusicLoop.play()

func _on_Button_pressed():
	$MusicLoop.stop()
	$MusicIntro.stop()
	get_tree().change_scene_to(ResourceManager.mainScene)


func _on_Main_animation_finished():
	$Node2D/Main.visible = false
	$Node2D/Loop.frame = 0
	$Node2D/Loop.visible = true
	$Node2D/Loop.play()


func _on_Main_frame_changed():
	if $Node2D/Main.frame == 70:
		$BossGrowl.play()
