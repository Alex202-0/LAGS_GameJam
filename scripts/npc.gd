extends Node2D

@onready var area := $Area2D
@onready var anim := $AnimationPlayer

var can_interact = false
var active_dialogue_box: Node = null

const DIALOG = preload("res://scenes/UI/DialogueBox.tscn")

func _physics_process(delta: float) -> void:
	if active_dialogue_box != null and not active_dialogue_box.is_inside_tree():
		active_dialogue_box = null
	anim.play("idle")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$Label.visible = true
		can_interact = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		$Label.visible = false
		can_interact = false
		
func _input(event):
	if Input.is_key_pressed(KEY_E) and can_interact and active_dialogue_box == null:
		$Label.visible = false
		active_dialogue_box = DIALOG.instantiate()
		get_tree().get_root().add_child(active_dialogue_box)
		var player = get_node("/root/Area1/Player") # Adjust to your actual path
		player.can_move = false
