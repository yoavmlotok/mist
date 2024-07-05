extends Hand


@onready var player = $".."

func _ready():
	if player.get_meta("has_spray_can"):
		var spray_can = preload("res://scenes/spray_can.tscn").instantiate()
		spray_can.set_meta("usable", true)
		add_child(spray_can)
