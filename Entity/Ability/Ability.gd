class_name Ability extends Node

enum TYPE{
    MELEE_SINGLE,
    MELEE_MULTI,
    RANGED_SINGLE,
    RANGED_MULTI,
}

@export var type : TYPE
@export var cooldown : float = 1.0
@export var damage : int = 10
@export var aoe_size : int
@export var sprite : AnimatedSprite2D
var is_attacking : bool = false
var active_attack : Area2D 
var hit_something : bool = false
var is_single : bool = true

var is_player = false
var parent : Node2D

func _ready() -> void:
    is_single = type % 2 == 0
    if parent == null:
        parent = get_parent()
    if sprite == null:
        sprite = get_node("AnimatedSprite2D")
    if sprite == null:
        queue_free()
    sprite.hide()

func activate(direction : int):
    if is_attacking and active_attack != null:
        return
    
    if active_attack != null:
        active_attack.queue_free()

    active_attack = Area2D.new()
    var col = CollisionShape2D.new()
    var rect = RectangleShape2D.new()
    rect.size = Vector2(aoe_size, aoe_size)
    col.shape = rect
    active_attack.add_child(col)
    var sp : AnimatedSprite2D = sprite.duplicate(0)
    sp.animation_finished.connect(attack_end)
    sp.show()
    active_attack.add_child(sp)
    active_attack.body_entered.connect(_on_body_entered)
    parent.add_child(active_attack)

    if direction == 0:
        active_attack.position.x += 63
        sp.rotation = 90
    elif direction == 1:
        active_attack.position.x -= 63
        sp.rotation = 180
    elif direction == 2:
        active_attack.position.y += 63
        sp.rotation = 180
    elif direction == 3:
        active_attack.position.y -= 63
        sp.rotation = 270
    
    hit_something = false
    is_attacking = true
#    if type >= Ability.TYPE.RANGED_MULTI:
#        set_process(true)
#    else:
#        set_process(false)

#func _process(_delta: float) -> void:
#    if active_attack:
#        active_attack.position 

func _on_body_entered(body:Node2D) -> void:
    if type % 2 == 0 and hit_something:
        return
    if not is_attacking:
        return

    if is_player and body is Enemy:
        body.hit(damage)
        if is_single:
            hit_something = true
    if not is_player and body is Player:
        body.hit(damage)
        if is_single:
            hit_something = true

func attack_end():
    is_attacking = false
    active_attack.hide()

func remove():
    if active_attack != null:
        active_attack.queue_free()
