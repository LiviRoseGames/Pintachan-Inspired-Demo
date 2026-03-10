extends Node2D

@onready var picker = $ColorPicker
@onready var sprite = $Sprite2D

func _ready():
	picker.color_changed.connect(_on_color_changed)

func _on_color_changed(color):
	sprite.material.set_shader_parameter("picked_color", color)
