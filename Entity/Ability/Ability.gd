class_name Ability extends Node

enum TYPE{
    MELEE_SINGLE,
    MELEE_MULTI,
    RANGED_SINGLE,
    RANGED_MULTI,
}

var type : TYPE
var damage : int = 10
var aoe : DamageArea
