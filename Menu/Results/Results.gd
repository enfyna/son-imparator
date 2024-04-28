extends Control
func _on_button_pressed() -> void:
    var start = load("res://Menu/StartMenu/StartMenu.tscn")
    get_tree().change_scene_to_packed(start)
func _on_button_2_pressed() -> void:
    get_tree().quit()
