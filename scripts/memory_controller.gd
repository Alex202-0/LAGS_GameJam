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
	memory_timer.start(memory_duration)


func _on_memory_timeout():
	_exit_memory_world()

func _exit_memory_world():
	visual_filter.exit_memory_filter()
	in_memory = false
