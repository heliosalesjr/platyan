extends Node

@onready var _pirate: CharacterBody2D = get_parent()

func _input(event : InputEvent) :
	if event.is_action_pressed("jump"):
		_pirate.jump()

func _process(_delta: float):
	_pirate.run(Input.get_axis("run_left", "run_right"))
