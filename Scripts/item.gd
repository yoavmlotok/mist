class_name Item
extends Node2D

func _on_picked_up():
	set_meta("usable", true)
