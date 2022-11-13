extends Node2D


func _ready():
	$TransitionScreen/AnimationPlayer.play("fade_to_normal")
	#yield(get_tree().create_timer(1), "timeout")
	#self.get_child(0).hide()
	yield(get_tree().create_timer(3), "timeout")
	$TransitionScreen/AnimationPlayer.play("fade_to_black")
	yield(get_tree().create_timer(1), "timeout")
	get_tree().change_scene("res://Title.tscn")
