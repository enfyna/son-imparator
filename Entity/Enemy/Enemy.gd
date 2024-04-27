class_name Enemy extends CharacterBody2D

@export var target : Node2D
@export var health : int
@onready var health_bar : ProgressBar = $HealthBar

func _ready() -> void:
    health_bar.value = health

func hit(damage:int):
    health -= damage
    if health <= 0:
        die()
    print(health)
    health_bar.value = health

func die():
    queue_free()
