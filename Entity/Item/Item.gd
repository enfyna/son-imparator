class_name Item extends Resource

enum RARITY {
    COMMON,
    NORMAL,
    RARE,
}

@export var item_name : StringName
@export var item_sprite : Texture2D
@export var item_rarity : RARITY
