extends RichTextLabel

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const dialog = [
	"Huh?! What are you doing here?!?",
	"You think you can fight? You have worse odds than BC football making playoffs...!",
	"I'm sorry. I can't let another innocent freshman perish in pursuit of CS degree...",
	"Wait...",
	"You survived a hackathon? Maybe you're the programmer we've been waiting for...",
	"Alright. I'll let you through.",
	"If you get stuck, remember that Alvarez drops your lowest homework/quiz grade...",
	"May your luck be O(n) and your troubles O(1).",
	"",
]
var sinceUpdate = 0
export var next = 1

# onready var test = $TransitionScreen/AnimationPlayer.play("fade_to_normal")
# Called when the node enters the scene tree for the first time.
func _ready():
	add_text(dialog[0])
	$TransitionScreen/AnimationPlayer.play("fade_to_normal")
	# push_font(get_font("normal_font"))

# Called every frame. 'delta' is the elapsed time (in seconds) since the previous frame.
func _process(delta):
	sinceUpdate += delta


# Called every event
func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_ENTER and sinceUpdate > 0.5:
			sinceUpdate = 0
			if next < dialog.size():
				clear()
				add_text(dialog[next])
			next += 1

