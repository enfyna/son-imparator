class_name Movement extends Node

var parent
@export var input : MovementInput
var audio : AudioStreamPlayer2D

func _ready() -> void:
    parent = get_parent()
    audio = $AudioStreamPlayer2D
    audio.play()

func _process(_delta: float) -> void:
    parent.velocity = input.get_input()
    if parent.leg_speed < 0:
        parent.leg_speed = 0
    parent.velocity *= Vector2(parent.leg_speed, parent.leg_speed)

    audio.stream_paused = parent.velocity.is_zero_approx() 
    parent.move_and_slide()
