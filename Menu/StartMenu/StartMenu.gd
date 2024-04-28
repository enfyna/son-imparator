class_name StartMenu extends Control
@onready var audio = $AudioStreamPlayer2D
func _on_button_pressed() -> void:
    var game = load("res://Level/Level.tscn")
    get_tree().change_scene_to_packed(game)
func _on_button_2_pressed() -> void:
    var bl : MarginContainer = $HBoxContainer/Control/MarginContainer
    bl.visible = !bl.visible
    audio.play()
