extends Node2D

var player_pos : Vector2
var point_pos : Vector2

var line_width = 3
var line_color = Color.BLACK

func _ready():
	SignalBus.connect("update_grapple_line", update_point)


func _draw():
	draw_line(point_pos, player_pos, line_color, line_width)


func _process(delta):
	queue_redraw()


func update_point(point, player, is_player):
	if is_player:
		player_pos = player
	if !is_player:
		point_pos = point
