class_name Player extends CharacterBody2D

var limbs : Array[Limb] = []
var direction : int = 0

func _ready() -> void:
    const limb_path = 'res://Entity/Item/Limbs/Player/'
    const ability_path = 'res://Entity/Ability/Default'
    var dir = DirAccess.open(limb_path)
    for limb_file in dir.get_files():
        var limb : Limb = load(limb_path + limb_file)
        if limb.ability_name.length() > 0:
            var ability_p = ability_path + "/" + limb.ability_name + ".tscn"
            if FileAccess.file_exists(ability_p):
                var ability : Ability = load(ability_p).instantiate()
                ability.parent = self
                ability.is_player = true
                limb.ability = ability
        limbs.append(limb)

func _process(delta: float) -> void:
    if Input.is_key_pressed(KEY_D):
        direction = 0
    elif Input.is_key_pressed(KEY_A):
        direction = 1
    if Input.is_key_pressed(KEY_S):
        direction = 2
    elif Input.is_key_pressed(KEY_W):
        direction = 3

    if Input.is_action_just_pressed('e'):
        limbs[3].ability.activate(direction)
    elif Input.is_action_just_pressed('q'):
        limbs[3].ability.activate(direction)
