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
@export var aoe : DamageArea
var active_attack = false

var is_player = false
var parent : Node2D

func activate(direction : int):
    if active_attack:
        return
    var dmg : DamageArea = aoe.duplicate()
    dmg.time = cooldown
    dmg.is_player = is_player
    dmg.damage = damage
    dmg.connect('end', func(): active_attack = false)
    if direction == 0:
        dmg.position.x += 129
    elif direction == 1:
        dmg.position.x -= 129
    elif direction == 2:
        dmg.position.y += 129
    elif direction == 3:
        dmg.position.y -= 129
    
    active_attack = true
    parent.add_child(dmg)
    

