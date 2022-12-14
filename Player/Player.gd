extends KinematicBody2D

export var ACCELERATION = 500
export var MAX_SPEED = 80
export var ROLL_SPEED = 125
export var FRICTION = 500

enum {
	MOVE, 
	ROLL,
	ATTACK
}

var state = MOVE
var velocity = Vector2.ZERO
var roll_vector = Vector2.DOWN
var stats = PlayerStats

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var swordHitbox = $HitboxPivot/SwordBox
onready var hurtBox = $Hurtbox
onready var sprite = $Sprite

func _ready():
	randomize()
	stats.connect("no_health", self, "queue_free")
	animationTree.active = true
	swordHitbox.knockback_vector = roll_vector
	swordHitbox.damage = stats.strength

func decrement_health():
	stats.health -= 1
	if stats.health <= 0:
		get_tree().change_scene("res://Dead.tscn")

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
			
		ROLL:
			roll_state(delta)
			
		ATTACK:
			attack_state(delta)

func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		swordHitbox.knockback_vector = input_vector
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationTree.set("parameters/Roll/blend_position", input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	move()
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK

	if Input.is_action_just_pressed("roll"):
		state = ROLL

func attack_state(detla):
	animationState.travel("Attack")
	
func roll_state(delta):
	hurtBox.start_inv(0.8)
	velocity = roll_vector * ROLL_SPEED
	animationState.travel("Roll")
	move()
	
func move():
	velocity = move_and_slide(velocity)
	
func attack_animation_finished():
	velocity = velocity * 0.75
	state = MOVE
	
func roll_animation_finished():
	state = MOVE
	
func upgrade_health():
	stats.set_health(stats.health + 2)
	stats.set_max_health(stats.max_health + 2)

func upgrade_damage():
	sprite.scale += sprite.scale * 0.2
	print(sprite.scale)
	stats.set_strength(stats.strength + 1)

func _on_Hurtbox_area_entered(area):
	hurtBox.start_inv(0.8)
	hurtBox.create_hit_effect()
	stats.health -= 1
	if stats.health <= 0:
		stats.set_health(3)
		stats.set_max_health(3)
		get_tree().change_scene("res://Dead.tscn")
