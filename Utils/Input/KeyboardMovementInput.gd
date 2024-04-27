class_name KeyboardMovementInput extends MovementInput

func get_input():
    var val : Vector2 = Vector2.ZERO

    if Input.is_key_pressed(KEY_W):
        val.y -= 500
    elif Input.is_key_pressed(KEY_S):
        val.y += 500
    if Input.is_key_pressed(KEY_D):
        val.x += 500
    elif Input.is_key_pressed(KEY_A):
        val.x -= 500

    return val
