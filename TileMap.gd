extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	for i in range(60):
		set_cell(i%10,i/10, rng.randi_range(0, 5))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
