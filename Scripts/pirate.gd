extends CharacterBody2D


@export var _speed : float = 300.0
@export var _acceleration : float = 300
@export var _deceleration : float = 300
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

	if _direction == 0:
		velocity.x = move_toward(velocity.x, 0, -_deceleration * delta)
	elif velocity.x == 0 || sign(_direction) == sign(velocity.x):
		velocity.x = move_toward(velocity.x, _direction * _speed, _acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, _direction * _speed, _deceleration * delta)

	move_and_slide()
