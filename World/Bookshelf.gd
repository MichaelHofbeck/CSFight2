extends StaticBody2D

var Effect = preload("res://Effects/BookshelfEffect.tscn")

func create_effect():
	var effect = Effect.instance()
	get_parent().add_child(effect)
	effect.global_position = global_position
	
func _on_Hurtbox_area_entered(area):
	create_effect()
	queue_free()
