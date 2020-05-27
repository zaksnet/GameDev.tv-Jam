extends Node2D
signal game_completed

var coins_count := 0
var coins_total := 0
var coin_display: Label
onready var coin_audio_player: AudioStreamPlayer = $CoinPlayer as AudioStreamPlayer
onready var win_audio_player: AudioStreamPlayer = $WinPlayer as AudioStreamPlayer


func _ready() -> void:
	coin_display = get_tree().get_nodes_in_group('CoinCounter').front() as Label
	var coins: Array = get_tree().get_nodes_in_group("Coin")
	coins_total = coins.size()
	_update_coin_display()
	_check_game_completed()

	for coin in coins:
		coin.connect('collected', self, '_on_Coin_collected')


func _update_coin_display() -> void:
	coin_display.text = '{count}/{total}'.format({'count': coins_count, 'total': coins_total})


func _check_game_completed() -> void:
	if coins_count == coins_total:
		emit_signal("game_completed")
		_play_win_sound()


func _play_win_sound() -> void:
	win_audio_player.play()


func _on_Coin_collected(coin: Coin) -> void:
	coins_count += 1
	coin.queue_free()
	coin_audio_player.play()
	_update_coin_display()
	_check_game_completed()
