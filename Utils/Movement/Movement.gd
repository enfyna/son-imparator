class_name Movement extends Node

var parent
@export var input : MovementInput

func _ready() -> void:
	parent = get_parent()

func _process(delta: float) -> void:
	parent.velocity = input.get_input()

	parent.move_and_slide()
