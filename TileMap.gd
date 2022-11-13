extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	for i in range(60):
		print(i%10, floor(i/10))
		set_cell(floor(i%10),floor(i/10), rng.randi_range(0, 5))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
