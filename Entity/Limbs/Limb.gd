class_name Limb extends Node

enum TYPE{
    ARM_LEFT,
    ARM_RIGHT,
    LEG_LEFT,
    LEG_RIGHT,
}

@export var type : TYPE
@export var action : Ability
@export var is_mech : bool = true
@export var condition : int = 90

