extends Node2D


func _ready():
	$TransitionScreen/AnimationPlayer.play("fade_to_normal")
	yield(get_tree().create_timer(1), "timeout")
	self.get_child(0).hide()

func _input(_event):
	if $YSort/Player.get_global_position()[0] >= 320:
		self.get_child(0).show()
		self.get_child(0).transition()
		yield(get_tree().create_timer(1), "timeout")
		get_tree().change_scene("res://Rewards.tscn")
