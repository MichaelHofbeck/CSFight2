extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree().create_timer(1), "timeout")
	$AnimationPlayer.play("Fade")
	for button in $Menu/CenterRow/Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
		
func _on_Button_pressed(scene_to_load):
	get_tree().change_scene(scene_to_load)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
