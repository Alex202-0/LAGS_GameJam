extends Control
var dialog = [
	"Hola explorador!",
	"Cuidado con el terreno, hubo un derrumbe.",
	"Y evita los animales, se ven que tienen hambre.",
	"Diviertete!"
]

var dialog_index = -1
var finished = false

func _ready():
	load_dialog()
	
func _physics_process(delta):
	$"Triangle".visible = finished
	if Input.is_action_just_pressed("interact"):
		load_dialog()

func load_dialog():
	if dialog_index < dialog.size():
		finished = false
		print(dialog[dialog_index])
		$CanvasLayer/RichTextLabel.text = dialog[dialog_index]
		$CanvasLayer/RichTextLabel.visible_ratio = 0
		var tween := get_tree().create_tween()
		tween.tween_property(
			$CanvasLayer/RichTextLabel, "visible_ratio", 1.0, 1.0
		)
		tween.tween_callback(Callable(self, "_on_dialogue_finished"))
	else:
		queue_free()

	dialog_index += 1
	

func _on_dialogue_finished():
	var player = get_node("/root/Area1/Player")
	if dialog_index >= dialog.size():
		player.can_move = true
	finished = true
