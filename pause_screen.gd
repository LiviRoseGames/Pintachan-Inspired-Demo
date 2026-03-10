extends Control


@onready var color_picker = $"../PauseScreen/CanvasLayer/ColorPicker"
@onready var player = $"../Player"


func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	color_picker.visible = false
	color_picker.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	color_picker.color_changed.connect(_on_color_changed)
	_on_color_changed(color_picker.color)


func _input(event):
	if event.is_action_pressed("ui_accept"):
		toggle_pause()


func toggle_pause():
	get_tree().paused = !get_tree().paused
	color_picker.visible = get_tree().paused


func _on_color_changed(color):
	for part in get_tree().get_nodes_in_group("primary_part"):
		part.material.set_shader_parameter("picked_color", color)

	for part in get_tree().get_nodes_in_group("secondary_part"):
		part.material.set_shader_parameter("picked_color", color)
			
	#player.get_node("Robot/Head").material.set_shader_parameter("player_color", color)
