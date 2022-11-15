extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.get_child(5).hide()
	$AnimationPlayer.play("Fade")
	yield(get_tree().create_timer(2), "timeout")
	
	self.get_child(4).hide()
	for button in $Menu/CenterRow/Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
		
	
		
func _on_Button_pressed(scene_to_load):
	self.get_child(5).show()
	self.get_child(5).transition()
	yield(get_tree().create_timer(1), "timeout")
	get_tree().change_scene(scene_to_load)

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
