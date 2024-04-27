class_name Collectible extends Area2D

@export var item : Item
var label : VBoxContainer


func _ready() -> void:
    if item == null:
        queue_free()
    label = get_node_or_null("Label")
    var t : RichTextLabel = label.get_node("RichTextLabel")
    t.text = t.text % item.item_name 
    label.hide()

func _on_body_entered(body:Node2D) -> void:
    if not body is Player:
        return
    label.show()

func _on_body_exited(body:Node2D) -> void:
    if not body is Player:
        return
    label.hide()
