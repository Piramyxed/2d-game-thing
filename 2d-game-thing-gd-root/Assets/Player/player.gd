extends CharacterBody2D

# Constant Contollers
const WALK_SPEED = 300.0
const SPRINT_SPEED = 500.0
const JUMP_VELOCITY = -400.0

# Movement Control
var slipperyness = 20

# States
var cur_speed = WALK_SPEED
var walking = false
var sprinting = true

func _ready():
	SignalBus.connect("grapple", grapple)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	
	if Input.is_action_pressed("sprint"):
		sprinting = true
		walking = false
	else:
		walking = true
		sprinting = false
	if walking:
		cur_speed = WALK_SPEED
	elif sprinting:
		cur_speed = SPRINT_SPEED
	
	if direction:
		velocity.x = lerp(velocity.x, direction * cur_speed, delta * slipperyness)
	else:
		velocity.x = lerp(velocity.x, 0.0, delta * slipperyness)

	move_and_slide()

func grapple(delta):
	SignalBus.emit_signal("update_grapple_line", Vector2.ZERO, global_position, true)
