class_name Limb extends Item

enum TYPE{
	ARM_LEFT,
	ARM_RIGHT,
	LEG_LEFT,
	LEG_RIGHT,
}

@export var type : TYPE
@export var ability_name : StringName
@export var is_mech : bool = true
@export var condition : int = 90

var ability : Ability

func remove():
    if ability != null:
        ability.queue_free()

