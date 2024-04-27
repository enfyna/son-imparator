class_name EnemyMovementInput extends MovementInput

@export var parent : Node2D
var target : Node2D

func _ready() -> void:
    target = parent.target

func get_input():
    var val : Vector2 = Vector2.ZERO
    var pos = parent.position + Vector2(64, 64)
    var tar = target.position + Vector2(64, 64)

    if pos.distance_to(tar) > 200:
        val.x = clamp(tar.x - pos.x, -100, 100)
        val.y = clamp(tar.y - pos.y, -100, 100) 

    return val
