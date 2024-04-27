class_name DamageArea extends Area2D

signal end

var is_single : bool = true
var is_player : bool = false
var time : float = 1.0
var damage : int = 10

func _on_body_entered(body:Node2D) -> void:
    if is_player and body is Enemy:
        body.hit(damage)
        if is_single:
            emit_signal('end')
            queue_free()
    if not is_player and body is Player:
        body.hit(damage)
        if is_single:
            emit_signal('end')
            queue_free()

    
func _process(delta: float) -> void:
    time -= delta
    if time < 0.0:
        emit_signal('end')
        queue_free()
