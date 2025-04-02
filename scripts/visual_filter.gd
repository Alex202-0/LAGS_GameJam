extends CanvasLayer

@onready var overlay := $Overlay
@onready var mat: ShaderMaterial = overlay.material

var fade_tween

func enter_memory_filter():
	print("Entered memory filter.")
	overlay.visible = true
	mat.set_shader_parameter("strength", 0.0) # start off
	mat.set_shader_parameter("desaturate", 0.8)
	mat.set_shader_parameter("darken", 0.2)

	if fade_tween and fade_tween.is_running():
		fade_tween.kill()

	fade_tween = create_tween()
	fade_tween.tween_method(func(val): mat.set_shader_parameter("strength", val), 0.0, 1.0, 0.5)

func exit_memory_filter():
	if fade_tween and fade_tween.is_running():
		fade_tween.kill()

	fade_tween = create_tween()
	fade_tween.tween_method(func(val): mat.set_shader_parameter("strength", val), 1.0, 0.0, 0.5)
	fade_tween.tween_callback(Callable(self, "_on_fade_out_finished"))

func _on_fade_out_finished():
	overlay.visible = false
