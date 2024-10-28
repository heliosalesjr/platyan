extends Camera2D

@export var _subject : Node2D
@export var _offset : Vector2
@export var _duration : float = 1
@onready var _look_ahead_distance : float = _offset.x

var _look_ahead_tween : Tween
var _floor_height_tween : Tween


func _ready():
	_offset *= Global.ppt

func _process(_delta: float):
	if _subject != null:
		position.x = _subject.position.x + _look_ahead_distance
	else:
		print("Erro: _subject não foi inicializado")
	
func _on_pirate_changed_direction(is_facing_left: bool):
	if _look_ahead_tween && _look_ahead_tween.is_running():
		_look_ahead_tween.kill()
	_look_ahead_tween = create_tween()
	_look_ahead_tween.tween_property(self, "_look_ahead_distance", _offset.x * (-1 if is_facing_left else 1), _duration )


func _on_pirate_landed(floor_height: float):
	position.y = floor_height + _offset.y
