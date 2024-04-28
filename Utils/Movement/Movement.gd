class_name Movement extends Node

var parent
@export var input : MovementInput

func _ready() -> void:
    parent = get_parent()

func _process(_delta: float) -> void:
    parent.velocity = input.get_input()
    if parent.leg_speed < 0:
        parent.leg_speed = 0
    parent.velocity *= Vector2(parent.leg_speed, parent.leg_speed)
    parent.move_and_slide()
