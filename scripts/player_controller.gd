extends CharacterBody2D

@export var speed = 10.0
@export var jump_power = 10.0


var speed_multiplier = 30.0
var jump_multiplier = -30.0
var direction = 0
var can_move := true

#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0

func die():
	get_tree().change_scene_to_file("res://scenes/Areas/Beginning_Area.tscn")
	

func _physics_process(delta: float) -> void:
	$AgentAnimator/AnimationPlayer.play("idle")
	if not can_move:
		velocity = Vector2.ZERO
		move_and_slide()
		return
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_power * jump_multiplier

	if Input.is_action_pressed("move_right"):
		$AgentAnimator/Sprite2D.scale.x = 1
	elif Input.is_action_pressed("move_left"):
		$AgentAnimator/Sprite2D.scale.x = -1

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed * speed_multiplier
	else:
		velocity.x = move_toward(velocity.x, 0, speed * speed_multiplier)

	move_and_slide()
	
func _unhandled_input(event):
	if event.is_action_pressed("close_eyes"):
		get_node("../MemoryController").toggle_memory_world()
