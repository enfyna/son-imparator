class_name EnemyMovementInput extends MovementInput

@export var parent : Node2D
var target : Node2D

func _ready() -> void:
	target = parent.target

func get_input():
	var val : Vector2 = Vector2.ZERO

	val.x = clamp(target.position.x - parent.position.x, -100, 100)
	val.y = clamp(target.position.y - parent.position.y, -100, 100) 

	return val
