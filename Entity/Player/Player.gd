class_name Player extends CharacterBody2D

var limbs : Dictionary = {}
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
                add_child(ability)
        limbs[limb.type] = limb

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
        if limbs[Limb.TYPE.ARM_RIGHT].ability != null:
            limbs[Limb.TYPE.ARM_RIGHT].ability.activate(direction)
    elif Input.is_action_just_pressed('q'):
        if limbs[Limb.TYPE.ARM_LEFT].ability != null:
            limbs[Limb.TYPE.ARM_LEFT].ability.activate(direction)

func hit(damage: int):
    print("player is hurt by %d" % damage)
    var limb : Limb = limbs[randi() % 4]
    if limb.condition > 0:
        limb.condition -= damage
    





