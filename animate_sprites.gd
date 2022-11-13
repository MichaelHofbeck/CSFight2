extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	self.get_child(1).visible = 0
	
func _input(event):
	var stage = get_node("../RichTextLabel").next - 1
	print(stage)
	if stage == 2:
		self.get_child(0).visible = 0
		self.get_child(1).visible = 1
	elif stage == 4:
		self.get_child(0).visible = 1
		self.get_child(1).visible = 0
	elif stage == 8:
		self.get_child(0).visible = 0
		self.get_child(2).visible = 0
		# ADD SCENE TRANSITION CODE HERE
		# EVAN TODO
