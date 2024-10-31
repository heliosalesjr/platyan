extends Area2D

@export var _splash : PackedScene

func _spawn_splash(x : float):
	if _splash:  # Verificação mínima
		var splash = _splash.instantiate()
		add_child(splash)
		splash.position.x = x

func _on_body_entered(body: Node2D):
	_spawn_splash(body.position.x)
	if body is Character:
		body.enter_water(position.y)

func _on_body_exited(body: Node2D) -> void:
	if body is Character:
		if body.position.y - float(Global.ppt) / 2 <= position.y:
			body.exit_water()
			_spawn_splash(body.position.x)
		else:
			body.dive()



	
