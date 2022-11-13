extends Control

func _ready():
	$TransitionScreen/AnimationPlayer.play("fade_to_normal")
	yield(get_tree().create_timer(1), "timeout")
	self.get_child(2).hide()


func _on_Button_pressed():
	self.get_child(2).show()
	self.get_child(2).transition()
	yield(get_tree().create_timer(1), "timeout")
	get_tree().change_scene("res://Title.tscn")
