class_name Collectible extends Area2D

@export var item : Item
var player : Player 
var panel : PanelContainer
var label : VBoxContainer

func _ready() -> void:
    if item == null:
        queue_free()
    panel = get_node("Control")
    label = panel.get_node("Label")
    var t : RichTextLabel = label.get_node("RichTextLabel")
    var limb_btns : HBoxContainer = label.get_node("LimbButtons")
    var aid_btns : HBoxContainer = label.get_node("AidButtons")
    if item is Limb:
        t.text = t.text % [item.item_name, Limb.TYPE.keys()[item.type], item.condition]
        aid_btns.hide()
        for btn in limb_btns.get_children():
            if Limb.TYPE[btn.name] != item.type:
                btn.hide()
            else:
                btn.pressed.connect(btn_confirmed.bind(btn.name))
    if item is Aid:
        t.text = t.text % [item.item_name, item.item_rarity, item.amount]
        limb_btns.hide()
    panel.hide()

func btn_confirmed(btn_name):
    if player == null:
        return
    print(btn_name)
    player.give_item(item)
    queue_free()
    

func _on_body_entered(body:Node2D) -> void:
    if not body is Player:
        return
    player = body
    panel.show()

func _on_body_exited(body:Node2D) -> void:
    if not body is Player:
        return
    player = null
    panel.hide()
