extends Item


@onready var player = $".."

func _ready():
	if player.get_meta("has_shield"):
		var shield = preload("res://Scenes/shield.tscn").instantiate()
		shield.set_meta("usable", true)
		add_child(shield)

func _process(_delta):
	pass
