extends CharacterBody2D


const SPEED = 300.0
const SPRINT_MULTIPLIER = 1.6

@onready var left_hand = $LeftHand
@onready var right_hand = $RightHand

func _process(_delta):
	var mouse_position = get_viewport().get_mouse_position()
	mouse_position += position - get_viewport_rect().size / 2.0
	rotation = position.angle_to_point(mouse_position) + PI / 2.0

func _physics_process(_delta):
	var speed = SPEED
	
	if Input.is_action_pressed("sprint"):
		speed = speed * SPRINT_MULTIPLIER
	
	var x_direction = Input.get_axis("move_left", "move_right")
	var y_direction = Input.get_axis("move_up", "move_down")
	
	var combined_direction = sqrt(
		x_direction * x_direction + y_direction * y_direction
		)
	if combined_direction > 1:
		x_direction /= combined_direction
		y_direction /= combined_direction
	
	if x_direction:
		velocity.x = x_direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	if y_direction:
		velocity.y = y_direction * speed
	else:
		velocity.y = move_toward(velocity.y, 0, speed)

	move_and_slide()

func _on_area_2d_area_entered(area):
	if !(area is Item):
		return
	
	if area is SprayCan && !get_meta("has_spray_can"):
		set_meta("has_spray_can", true)
		
		area.get_parent().remove_child(area)
		right_hand.call_deferred("add_child", area)
		
		area._on_picked_up()
		return
	if area is Shield && !get_meta("has_shield"):
		set_meta("has_shield", true)
		
		area.get_parent().remove_child(area)
		left_hand.call_deferred("add_child", area)
		
		area._on_picked_up()
