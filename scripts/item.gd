class_name Item
extends Area2D

func _on_picked_up():
	set_deferred("monitorable", false)
	position = Vector2(0, 0)
	set_meta("usable", true)
