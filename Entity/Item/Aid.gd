class_name Aid extends Item

enum TYPE{
	ARM_LEFT,
	ARM_RIGHT,
	LEG_LEFT,
	LEG_RIGHT,
    ORGAN,
    ALL,
}

@export var type : Aid.TYPE
@export var amount : int
@export var randomize_type : bool = false

