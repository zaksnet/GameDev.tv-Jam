extends BaseCoin
signal collected

class_name Coin


func _on_Coin_body_entered(body: Player):
	emit_signal('collected', self)
