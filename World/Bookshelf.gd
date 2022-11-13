extends StaticBody2D



func create_bookshelf_effect():
	var BookshelfEffect = load("res://Effects/BookshelfEffect.tscn")
	var bookshelfEffect = BookshelfEffect.instance()
	var world = get_tree().current_scene
	world.add_child(bookshelfEffect)
	bookshelfEffect.global_position = global_position
	
func _on_Hurtbox_area_entered(area):
	create_bookshelf_effect()
	queue_free()
