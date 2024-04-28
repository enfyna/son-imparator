class_name Player extends CharacterBody2D

const ability_path = 'res://Entity/Ability/Default'

var leg_speed : float = 1.0
var limbs : Dictionary = {}
var direction : int = 0
@onready var sprite : AnimatedSprite2D = $Sprite2D

func _ready() -> void:
    const limb_path = 'res://Entity/Item/Limbs/Player/'
    var dir = DirAccess.open(limb_path)
    for limb_file in dir.get_files():
        limb_file = limb_file.trim_suffix(".remap")
        var limb : Limb = load(limb_path + limb_file)
        if limb.ability_name.length() > 0:
            var ability_p = ability_path + "/" + limb.ability_name + ".tscn"
            var ability : Ability = load(ability_p).instantiate()
            ability.parent = self
            ability.is_player = true
            limb.ability = ability
            add_child(ability)
        limbs[limb.type] = limb
    sprite.play("default")

func _process(_delta: float) -> void:
    var anim : String = "default"
    if Input.is_key_pressed(KEY_D):
        direction = 0
        anim = "move_right"
    elif Input.is_key_pressed(KEY_A):
        direction = 1
        anim = "move_left"
    if Input.is_key_pressed(KEY_S):
        direction = 2
        anim = "move_front"
    elif Input.is_key_pressed(KEY_W):
        direction = 3
        anim = "move_back"
    sprite.play(anim)

    if Input.is_key_pressed(KEY_E):
        if limbs[Limb.TYPE.ARM_RIGHT].ability != null:
            limbs[Limb.TYPE.ARM_RIGHT].ability.activate(direction)
    elif Input.is_key_pressed(KEY_Q):
        if limbs[Limb.TYPE.ARM_LEFT].ability != null:
            limbs[Limb.TYPE.ARM_LEFT].ability.activate(direction)

func hit(damage: int):
    var limb : Limb = limbs[randi() % 4]
    if limb.condition > 0:
        limb.hit(damage)
        if limb.type >= Limb.TYPE.LEG_LEFT:
            leg_speed = (limbs[Limb.TYPE.LEG_LEFT].condition + limbs[Limb.TYPE.LEG_RIGHT].condition) / 200.0
    
func give_item(item: Item, btn_name: String):
    if item is Limb:
        var current_limb = limbs[item.type]
        current_limb.remove()

        if item.ability_name.length() > 0:
            var ability_p = ability_path + "/" + item.ability_name + ".tscn"
            var ability : Ability = load(ability_p).instantiate()
            ability.parent = self
            ability.is_player = true
            item.ability = ability
            add_child(ability)
        limbs[item.type] = item

    elif item is Aid:
        if item.type == Aid.TYPE.ORGAN:

            pass
        elif item.type == Aid.TYPE.ALL:
            var limb = limbs[Limb.TYPE.get(btn_name)]
            if limb.condition > 0:
                limb.hit(-item.amount)
            else:
                for lm in limbs.values():
                    if lm != null and lm.condition > 0:
                        lm.hit(-item.amount)
        leg_speed = (limbs[Limb.TYPE.LEG_LEFT].condition + limbs[Limb.TYPE.LEG_RIGHT].condition) / 200.0




