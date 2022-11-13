extends Node2D

func create_pebble_effect():
	var PebbleEffect = load("res://Effects/PebbleEffect.tscn")
	var pebbleEffect = PebbleEffect.instance()
	var world = get_tree().current_scene
	world.add_child(pebbleEffect)
	pebbleEffect.global_position = global_position
	
func _on_Hurtbox_area_entered(area):
	create_pebble_effect()
	queue_free()
