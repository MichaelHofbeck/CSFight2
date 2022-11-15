extends Node2D


func _ready():
	$TransitionScreen/AnimationPlayer.play("fade_to_normal")
	yield(get_tree().create_timer(1), "timeout")
	self.get_child(0).hide()
