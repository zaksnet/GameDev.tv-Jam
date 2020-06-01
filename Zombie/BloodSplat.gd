extends CPUParticles2D

var rot

func _ready():

	if abs(rot) > 2:
		direction = Vector2(-1, 0)
	emitting = true

	
func _process(delta):
	if emitting == false:
		queue_free()
