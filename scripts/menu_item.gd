extends HBoxContainer

signal selected

@export var label_text: String = "Menu Option"
@export var icon_texture: Texture

@onready var label := $Label
@onready var icon := $Icon
@onready var anim := $AnimationPlayer

func _ready():
	label.text = label_text
	icon.texture = icon_texture

	set_focus_mode(FOCUS_ALL)
	mouse_entered.connect(_on_hover)
	mouse_exited.connect(_on_unhover)
	focus_entered.connect(_on_hover)
	focus_exited.connect(_on_unhover)

func _on_hover():
	anim.play("focus")
	

func _on_unhover():
	anim.play("unfocus")
	
func _gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		emit_signal("selected")
	if event.is_action_pressed("ui_accept"):
		emit_signal("selected")
