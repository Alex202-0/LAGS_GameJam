extends Node2D

@onready var transition := $Transition

func _ready():
	transition.start_fade()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
