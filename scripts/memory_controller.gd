extends Node

@onready var visual_filter := $"../VisualFilter"

var memory_duration := 7.0
var in_memory := false
var memory_timer := Timer.new()

func _ready():
	add_child(memory_timer)
	memory_timer.one_shot = true
	memory_timer.timeout.connect(_on_memory_timeout)

func toggle_memory_world():
	if in_memory:
		print("Already in memory world.")
		return
	print("Toggling memory world!")
	in_memory = true
	visual_filter.enter_memory_filter()
	_toggle_hazards(false)
	memory_timer.start(memory_duration)

func _toggle_hazards(active: bool):
	var hazards = get_tree().get_nodes_in_group("hazard")
	for hazard in hazards:
		if hazard.has_method("set_active"):
			print("Setting active:", hazard.name)
			hazard.set_active(active)
		else:
			# Fallback in case some hazards don’t have that method yet
			if hazard.has_method("set_visible"):
				hazard.visible = active
			if hazard.has_node("HitBox"):
				hazard.get_node("HitBox").monitoring = active

func _on_memory_timeout():
	_exit_memory_world()

func _exit_memory_world():
	visual_filter.exit_memory_filter()
	_toggle_hazards(true)
	in_memory = false
