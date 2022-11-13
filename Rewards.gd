extends Control


func _ready():
	$TransitionScreen/AnimationPlayer.play("fade_to_normal")
	yield(get_tree().create_timer(1), "timeout")
	self.get_child(3).hide()

func _on_Button1_pressed():
	#$World/YSort/Player.get_ += 20
	self.get_child(3).show()
	self.get_child(3).transition()
	yield(get_tree().create_timer(1), "timeout")
	get_tree().change_scene("res://cutscene.tscn")



func _on_Button2_pressed():
	#$WorldYSort/Player.damage += 20
	self.get_child(3).show()
	self.get_child(3).transition()
	yield(get_tree().create_timer(1), "timeout")
	get_tree().change_scene("res://cutscene.tscn")
