extends Area2D

@onready var icon = $pointSprite
var active = false
var holdMouse

func _process(delta):
	if active:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			SignalBus.emit_signal("grapple", get_process_delta_time())
		

func _on_mouse_entered():
	active = true
	icon.scale = Vector2(0.4, 0.4)


func _on_mouse_exited():
	active = false
	icon.scale = Vector2(0.3, 0.3)
