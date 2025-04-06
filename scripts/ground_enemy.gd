extends "res://scripts/enemy_base.gd"

@export var walk_speed := 40.0
@export var chase_speed := 90.0
@export var gravity := 800.0
@export var acceleration := 200.0

@onready var player := get_node("/root/Area1/Player") # Update path if needed
@onready var detection_area := $DetectionArea
@onready var hitbox := $HitBox

@onready var sprite := $AnimatedSprite2D # Animated sprite node


enum State { WANDER, CHASE, HIT }
var state: State = State.WANDER
var direction := -1

func _ready():
	super() # Call parent _ready() first

	hitbox.body_entered.connect(_on_hitbox_body_entered)
	detection_area.body_entered.connect(_on_player_detected)
	detection_area.body_exited.connect(_on_player_lost)

func _physics_process(delta):
	velocity.y += gravity * delta

	match state:
		State.WANDER:
			_do_wander(delta)
		State.CHASE:
			_do_chase(delta)
		State.HIT:
			velocity.x = 0
			_play_anim("default")


	move_and_slide()

func _do_wander(delta):
	velocity.x = move_toward(velocity.x, direction * walk_speed, acceleration * delta)
	if is_on_wall():
		direction *= -1
	_update_sprite_direction()
	_play_anim("default")


func _do_chase(delta):
	if not player:
		state = State.WANDER
		return

	var to_player = player.global_position - global_position
	direction = sign(to_player.x)
	velocity.x = move_toward(velocity.x, direction * chase_speed, acceleration * delta)
	_update_sprite_direction()
	_play_anim("default")


func _on_hitbox_body_entered(body):
	if body.name == "Player":
		state = State.HIT
		print("💥 Enemy hit the player!")

func _on_player_detected(body):
	if body.name == "Player" and state != State.HIT:
		state = State.CHASE

func _on_player_lost(body):
	if body.name == "Player" and state != State.HIT:
		state = State.WANDER

func _update_sprite_direction():
	# ✅ Flip horizontally only if moving right (assuming sprite faces LEFT by default)
	sprite.flip_h = direction > 0

func _play_anim(anim_name: String):
	if sprite.animation != anim_name or !sprite.is_playing():
		sprite.play(anim_name)
