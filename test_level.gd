extends Node2D

@onready var color_picker = $PauseScreen/CanvasLayer/ColorPicker
@onready var player = $Player


func _ready():
	#process_mode = Node.PROCESS_MODE_ALWAYS
	color_picker.visible = false
	color_picker.color_changed.connect(_on_color_changed)
	color_picker.process_mode = Node.PROCESS_MODE_WHEN_PAUSED


func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"): # space bar by default
		toggle_pause()


func toggle_pause():
	get_tree().paused = !get_tree().paused
	color_picker.visible = get_tree().paused


func _on_color_changed(color):
	player.get_node("Robot/Head").material.set_shader_parameter("player_color", color)
