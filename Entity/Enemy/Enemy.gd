class_name Enemy extends CharacterBody2D

@export var target : Node2D
@export var health : int
@export var ability : Ability
@onready var health_bar : ProgressBar = $HealthBar
@onready var sprite : AnimatedSprite2D = $Sprite2D

var leg_speed : float = 1.0
var direction : int

func _ready() -> void:
    health_bar.value = health
    add_child(ability)

func hit(damage:int):
    health -= damage
    if health <= 0:
        die()
    health_bar.value = health

func die():
    if randi() % 75 > 50:
        queue_free()

    var col = load("res://Entity/Collectible/Collectible.tscn").instantiate()
    col.position = position

    if randi() % 50 > 10:
        const dir = "res://Entity/Item/Aid/"
        var aid_dir = DirAccess.get_files_at(dir)
        var pt = dir + aid_dir[randi() % aid_dir.size()]
        pt = pt.trim_suffix(".remap")
        col.item = load(pt)
    else:
        const dir = "res://Entity/Item/Limbs/Enemy_L1/"
        var limb_dir = DirAccess.get_files_at(dir)
        var pt = dir + limb_dir[randi() % limb_dir.size()]
        pt = pt.trim_suffix(".remap")
        col.item = load(pt)
    get_parent().call_deferred("add_child", col)
    call_deferred("queue_free")

func _process(_delta: float) -> void:
    var anim : String = "default"
    var dif_x = target.position.x - position.x
    var dif_y = target.position.y - position.y
    if abs(dif_x) > abs(dif_y):
        if dif_x < 0:
            direction = 1
            anim = "move_left"
        else:
            direction = 0
            anim = "move_right"
    else:
        if dif_y < 0:
            direction = 3
            anim = "move_back"
        else:
            direction = 2
            anim = "move_front"

    sprite.play(anim)

    if ability and ability.type < 2:
        if position.distance_to(target.position) < 180:
            ability.activate(direction)
