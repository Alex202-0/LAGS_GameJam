extends CharacterBody2D

var stored_position: Vector2 = Vector2.ZERO

func _ready():
	# Save spawn position
	stored_position = global_position
	
	# Add to hazard group so memory controller finds it
	add_to_group("hazard")

func set_active(state: bool):
	print("set_active called with:", state)

	if state:
		global_position = stored_position
		show()
	else:
		stored_position = global_position
		hide()

	# Enable/disable main collision shape
	if has_node("CollisionShape2D"):
		$CollisionShape2D.set_deferred("disabled", not state)

	# Enable/disable hitbox (if it exists)
	if has_node("HitBox"):
		var hitbox = $HitBox
		hitbox.monitoring = state

		if hitbox.has_node("CollisionShape2D"):
			hitbox.get_node("CollisionShape2D").set_deferred("disabled", not state)

	# Optional: stop movement when inactive
	if not state:
		velocity = Vector2.ZERO
