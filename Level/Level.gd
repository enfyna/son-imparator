class_name Level extends Node2D

@export var EnemySpawnLoc : Array[Marker2D] = []
var time_to_spawn : int = 7
var current_time : float = 0.0
var diff : int = 1

var enemy_scene
var abilities : Array[PackedScene] = []
var player : Player

var basic_hit = "res://Entity/Ability/Default/BasicSwordHit.tscn"
var normal_hit = "res://Entity/Ability/Default/SwordHit.tscn"

func _ready() -> void:
    player = get_node("Player")
    enemy_scene = load("res://Entity/Enemy/Enemy.tscn")


func _process(delta: float) -> void:
    current_time += delta
    if current_time > time_to_spawn:
        var enemy = enemy_scene.instantiate()
        enemy.position = EnemySpawnLoc.pick_random().position
        if diff == 1:
            enemy.ability = load(basic_hit).instantiate()
        else:
            enemy.ability = load(normal_hit).instantiate()
        enemy.target = player
        add_child(enemy)
        current_time = 0.0
    

