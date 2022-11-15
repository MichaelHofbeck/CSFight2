extends Label


var dList = ["Welcome to CS Fight II...", "Use the arrows to move around and spacebar to attack. ", "Press shift to roll.","Walk up to get started!"]

# Called when the node enters the scene tree for the first time.
func _ready():
	$DialogueBox.get_child(0).setDialouge(dList)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
