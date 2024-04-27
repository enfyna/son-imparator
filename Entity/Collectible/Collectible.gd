class_name Collectible extends Area2D

@export var item : Item
var label : VBoxContainer


func _ready() -> void:
    if item == null:
        queue_free()
    label = get_node_or_null("Label")
    var t : RichTextLabel = label.get_node("RichTextLabel")
    var limb_btns : HBoxContainer = label.get_node("LimbButtons")
    var aid_btns : HBoxContainer = label.get_node("AidButtons")
    if item is Limb:
        t.text = t.text % [item.item_name, Limb.TYPE.keys()[item.type], item.condition]
        aid_btns.hide()
        for btn in limb_btns.get_children():
            if Limb.TYPE[btn.name] != item.type:
                btn.hide()
    if item is Aid:
        t.text = t.text % [item.item_name, item.item_rarity, item.amount]
        limb_btns.hide()
    label.hide()

func _on_body_entered(body:Node2D) -> void:
    if not body is Player:
        return
    label.show()

func _on_body_exited(body:Node2D) -> void:
    if not body is Player:
        return
    label.hide()
