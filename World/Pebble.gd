extends Node2D

func _process(delta):
	if Input.is_action_just_pressed("attack"):
		var PebbleEffect = load("res://Effects/PebbleEffect.tscn")
		var pebbleEffect = PebbleEffect.instance()
		var world = get_tree().current_scene
		world.add_child(pebbleEffect)
		pebbleEffect.global_position = global_position
		queue_free()
