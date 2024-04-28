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

func hit(damage:int):
    if condition >= 0:
        condition -= damage
        if condition > 100:
            condition = 100
    if condition <= 0:
        if ability != null:
            ability.queue_free()

func remove():
    if ability != null:
        ability.remove()
        ability.call_deferred("queue_free")

