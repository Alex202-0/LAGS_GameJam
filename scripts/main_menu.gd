extends Control

@onready var TransitionScene := preload("res://scenes/transition.tscn")
var transition: Node = null

func _on_new_game_selected() -> void:
	var transition = TransitionScene.instantiate()
	add_child(transition)
	var connected =  transition.finished_blink.connect(Callable(self, "_on_transition_blink_finished"))

	print("Connected finished_blink signal:", connected)
	
	transition.start_blink()

func _on_transition_blink_finished():
	print("Transition finished. Playing instructions.")
	var transition = TransitionScene.instantiate()
	add_child(transition)
	var connected =  transition.finished_instructions.connect(Callable(self, "_on_transition_instructions_finished"))
	
	transition.start_instructions()
	
func _on_transition_instructions_finished():
	print("Transition finished. Loading level 1.")
	get_tree().change_scene_to_file("res://scenes/Areas/Area1.tscn")


func _on_continue_selected() -> void:
	pass # Replace with function body.

func _on_options_selected() -> void:
	$OptionMenu.visible = true
	$MenuContainer.visible = false

func _on_quit_selected() -> void:
	get_tree().quit()
