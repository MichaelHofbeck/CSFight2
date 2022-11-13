extends KinematicBody2D

const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")

export var ACCELERATION = 300
export var MAX_SPEED = 40
export var FRICTION = 200

enum{
	IDLE,
	WANDER,
	CHASE
}

var state = CHASE
var velocity = Vector2.ZERO
var knockback = Vector2.ZERO
var last_attack = 0
var in_attack = 0
var rng = RandomNumberGenerator.new()
var new_x = -1
var new_y = -1
var die = -1
var flip = 0
var last_change = 0

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var tile_map = get_node("../TileMap")
onready var player = get_node("../Player")

# onready var sprite = $AnimatedSprite
onready var stats = $Stats
onready var playerDetectionZone = $PlayerDetectionZone
onready var hurtbox = $Hurtbox

func _physics_process(delta):
	animationTree.active = true
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)
	
	if velocity != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", velocity)
		animationTree.set("parameters/Run/blend_position", velocity)
		animationTree.set("parameters/Attack/blend_position", velocity)
		animationState.travel("Run")
	else:
		animationState.travel("Idle")
	
	if tile_map != null and last_attack > 3.8:
		if state != IDLE:
			state = IDLE
		if new_x == -1:
			rng.randomize()
			
		in_attack += delta
		if in_attack > 2:
			
			last_attack = 0
			in_attack = 0
			new_x = -1
		elif in_attack < 0.5:
			pass
		elif in_attack < 1.75:
			if new_x == -1:
				new_x = rng.randi_range(30, 320)
				new_y = rng.randi_range(30, 180)					
				self.hide()
				die = rng.randi_range(0, 5)
				tile_map.tile_set.tile_set_modulate(die, Color(0, 1, 0.498039, 1))
		else:
			if self.get_global_position()[0] != new_x:
				set_position(Vector2(new_x, new_y))
				self.show()
				tile_map.tile_set.tile_set_modulate(die, Color( 1, 1, 1, 1 ))
				if die != tile_map.get_cell(player.get_global_position()[0] / 32, player.get_global_position()[1] / 32):
					player.hurtBox.start_inv(0.8)
					player.hurtBox.create_hit_effect()
					player.decrement_health()
	else:
		last_attack += delta
		
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, 200 * delta)
			if not last_attack > 3.8:
				seek_player()
			
		WANDER:
			pass
			
		CHASE:
			var player = playerDetectionZone.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				if tile_map == null or stats.health >= 10:
					velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
				else:
					if last_change > 1.5:
						flip = rng.randi_range(0, 1)
						last_change = 0
					else:
						last_change += delta
					if flip == 0:
						velocity = velocity.move_toward(Vector2(-1,0) * MAX_SPEED, ACCELERATION * delta * 5)
					else:
						velocity = velocity.move_toward(Vector2(0,1) * MAX_SPEED, ACCELERATION * delta * 5)
			else:
				state = IDLE
	velocity = move_and_slide(velocity)
	
			
func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE

func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	hurtbox.create_hit_effect()
	knockback = area.knockback_vector * 120
	
func _on_Stats_no_health():
	queue_free()
	var enemyDeathEffect = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position
	get_tree().change_scene("res://Win.tscn")
