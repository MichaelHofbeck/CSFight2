extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$TransitionScreen/AnimationPlayer.play("fade_to_normal")
	yield(get_tree().create_timer(1), "timeout")
	self.get_child(0).hide()

func _input(_event):
	if $YSort/Player.get_global_position()[1] <= 0:
		self.get_child(7).show()
		self.get_child(7).transition()
		yield(get_tree().create_timer(1), "timeout")
		get_tree().change_scene("res://cutscene.tscn")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
