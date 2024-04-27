class_name LimbHUD extends CanvasLayer

@export var player : Player
@export var limb : Limb.TYPE

var label : Label
var bar : ProgressBar

func _ready() -> void:
    label = $MarginContainer/Panel/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/Ability
    bar = $MarginContainer/Panel/HBoxContainer/MarginContainer/VBoxContainer/ProgressBar

func _process(_delta: float) -> void:
    var current_limb = player.limbs[limb]
    label.text = current_limb.ability_name
    bar.value = player.limbs[limb].condition
