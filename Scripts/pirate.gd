extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var _direction : float

#region public methods

func face_left():
	pass

func face_right():
	pass
	
func run(direction: float):
	_direction = direction

func jump():
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
#endregion

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if _direction:
		velocity.x = _direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
