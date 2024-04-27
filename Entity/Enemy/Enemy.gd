class_name Enemy extends CharacterBody2D

@export var target : Node2D
@export var health : int
@export var ability : Ability
@onready var health_bar : ProgressBar = $HealthBar

var direction : int

func _ready() -> void:
    health_bar.value = health

func hit(damage:int):
    health -= damage
    if health <= 0:
        die()
    health_bar.value = health

func die():
    queue_free()

func _process(delta: float) -> void:
    var dif_x = target.position.x - position.x
    var dif_y = target.position.y - position.y
    if abs(dif_x) > abs(dif_y):
        if dif_x < 0:
            direction = 1
        else:
            direction = 0
    else:
        if dif_y < 0:
            direction = 3
        else:
            direction = 2

    if ability.type < 2:
        if position.distance_to(target.position) < 180:
            ability.activate(direction)
