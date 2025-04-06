extends CanvasLayer

@onready var blackTop := $BlackScreenTop
@onready var blackBottom := $BlackScreenBottom
@onready var anim := $AnimationPlayer

signal finished_blink
signal finished_instructions

func start_instructions():
	anim.play("instructions")

func start_blink():
	blackTop.visible = true
	blackBottom.visible = true
	anim.play("blink")

func start_fade():
	blackTop.visible = true
	blackTop.modulate.a = 1.0
	blackBottom.visible = true
	blackBottom.modulate.a = 1.0
	anim.play("fade in")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	print("Animation finished:", anim_name)

	if anim_name == "blink":
		print("Emitting finished_blink")
		emit_signal("finished_blink")
	elif anim_name == "fade in":
		print("Fade-in done, hiding black screens")
		blackTop.visible = false
		blackBottom.visible = false
		queue_free()
	elif anim_name == "instructions":
		print("Emitting finished_instructions")
		emit_signal("finished_instructions")
