class_name Level extends Node2D

@export var EnemySpawnLoc : Array[Marker2D] = []
@onready var Enemies : Node2D = $Enemies
var time_to_spawn : int = 5
var passed_time : float = 0.0
var current_time : float = 0.0
var diff : int = 1

var enemy_scene
var abilities : Array[PackedScene] = []
var player : Player

var basic_hit = "res://Entity/Ability/Default/BasicSwordHit.tscn"
var normal_hit = "res://Entity/Ability/Default/SwordHit.tscn"
var ulti_hit = "res://Entity/Ability/Default/UltimateSwordHit.tscn"

func _ready() -> void:
    player = get_node("Player")
    enemy_scene = load("res://Entity/Enemy/Enemy.tscn")


func _process(delta: float) -> void:
    var life = 0.0
    for limb in player.limbs.values():
        if limb != null:
            life += limb.condition
    if life < 1:
        var res = load("res://Menu/Results/Results.tscn").instantiate()
        res.time = passed_time
        get_node("/root").add_child(res)
        queue_free()

    passed_time += delta
    if passed_time > 20:
        diff = 2
    if passed_time > 60:
        diff = 3
    current_time += delta
    if Enemies.get_child_count() >= 3:
        return
    if current_time > time_to_spawn:
        var enemy = enemy_scene.instantiate()
        enemy.position = EnemySpawnLoc.pick_random().position
        if diff == 1:
            enemy.ability = load(basic_hit).instantiate()
        elif diff == 2:
            enemy.ability = load(normal_hit).instantiate()
        else:
            enemy.ability = load(ulti_hit).instantiate()
        enemy.target = player
        Enemies.add_child(enemy)
        current_time = 0.0
    

