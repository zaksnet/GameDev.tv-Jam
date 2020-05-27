extends Node2D
class_name GameCamera

var draw_color: Color = Color(1.0, 0.5, 0.0, 0.5)
export var draw_angle_from = 0
export var draw_angle_to = 180
export var draw_width = 60
export var draw_dir = 0
export var default_draw_speed = 10
var current_angle = 0


signal body_entered
signal body_exited

func _ready():
	if draw_dir:
		current_angle = draw_angle_to
		
	$Tween.connect("tween_all_completed", self, "start_moving")
	start_moving()

	
func start_moving():

	if current_angle < draw_angle_to:
		$Tween.interpolate_property(self, "current_angle", draw_angle_from, draw_angle_to, default_draw_speed, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
		$Tween.interpolate_property($Area2D, "rotation_degrees", draw_angle_from, draw_angle_to, default_draw_speed, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
		$Tween.start()
	#draw_dir = 1
	elif current_angle >= draw_angle_to:
		$Tween.interpolate_property(self, "current_angle", draw_angle_to, draw_angle_from, default_draw_speed, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
		$Tween.interpolate_property($Area2D, "rotation_degrees", draw_angle_to, draw_angle_from, default_draw_speed, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
		
		$Tween.start()

func resume_moving():
	$Tween.resume_all()
	
func stop_moving():
	$Tween.stop_all()

func _draw():
	var center = Vector2(0, 0)
	var radius = 150
	var angle_from = current_angle
	var angle_to = current_angle + draw_width
	var color = draw_color
	draw_circle_arc_poly(center, radius, angle_from, angle_to, color)
	
func draw_circle_arc_poly(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PoolVector2Array()
	points_arc.push_back(center)
	var colors = PoolColorArray([color])

	for i in range(nb_points + 1):
		var angle_point = deg2rad(angle_from + i * (angle_to - angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
	draw_polygon(points_arc, colors)

func _on_Area2D_body_entered(body):
	emit_signal("body_entered")

func _on_Area2D_body_exited(body):
	emit_signal("body_exited")
