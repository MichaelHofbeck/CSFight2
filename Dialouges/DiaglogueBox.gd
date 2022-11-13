# DialogueBox.gd
# Template for Dialogue Box
extends RichTextLabel


var dialouge = ["Here"]
var page = -1

func setDialouge(d_array):
	dialouge = d_array
	page += 1
	set_bbcode(dialouge[page])
	set_visible_characters(0)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	# set_bbcode(dialouge[page])
	set_visible_characters(0)
	set_process_input(true)

func _input(event):
	if event is InputEventKey and event.pressed:
		if page == dialouge.size() - 1 and get_visible_characters() > get_total_character_count():
			get_parent().queue_free()
		if get_visible_characters() > get_total_character_count():
			if page < dialouge.size() - 1:
				page += 1
				set_bbcode(dialouge[page])
				set_visible_characters(0)
		else:
			set_visible_characters(get_total_character_count())
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	set_visible_characters(get_visible_characters() + 1)
