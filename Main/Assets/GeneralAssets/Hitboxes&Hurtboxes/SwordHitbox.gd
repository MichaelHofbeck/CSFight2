extends "res://Hurtboxes + Hitboxes/Hitbox.gd"

var knockback_vector = Vector2.ZERO

func upgrade_damage():
	self.damage += 1
