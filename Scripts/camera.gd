extends Camera2D

@export var _subject: Node2D
@export var _offset: Vector2
@export var _trans_type: Tween.TransitionType
@export var _ease_type: Tween.EaseType
@export var _duration: float = 1
@onready var _look_ahead_distance: float = _offset.x

var _floor_height: float = 0.0  # Inicializado com valor padrão
var _look_ahead_tween: Tween = null
var _floor_height_tween: Tween = null

func _ready():
	_offset *= Global.ppt
	if _subject != null:
		_floor_height = _subject.position.y  # Define o valor inicial do piso com a posição do sujeito

func _process(_delta: float):
	if _subject != null:
		position.x = _subject.position.x + _look_ahead_distance
	else:
		print("Erro: _subject não foi inicializado")

func _on_pirate_changed_direction(is_facing_left: bool):
	if _look_ahead_tween != null and _look_ahead_tween.is_running():
		_look_ahead_tween.kill()
	_look_ahead_tween = create_tween().set_trans(_trans_type).set_ease(_ease_type)
	_look_ahead_tween.tween_property(self, "_look_ahead_distance", _offset.x * (-1 if is_facing_left else 1), _duration)

func _on_pirate_landed(floor_height: float):
	if _floor_height_tween != null and _floor_height_tween.is_running():
		_floor_height_tween.kill()
	_floor_height_tween = create_tween().set_trans(_trans_type).set_ease(_ease_type)
	_floor_height_tween.tween_property(self, "position:y", floor_height + _offset.y, _duration)  # Ajusta diretamente a posição y
