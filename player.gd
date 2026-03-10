extends CharacterBody2D

@export var movement_data : PlayerMovementData

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var wheel_radius = 41.0 # adjust this to match your wheel size in pixels

#antenne
var max_angle = deg_to_rad(40)  # 40 degrees in radians
var spring_speed = deg_to_rad(720)   # how fast it snaps back
var rotation_velocity = 0.0

#@onready var wheels = get_tree().get_nodes_in_group("wheel")

@onready var starting_position = global_position

@onready var wheel1 = $Robot/Legs/RobotLeg/Wheel
@onready var wheel2 = $Robot/Legs/RobotLeg2/Wheel
@onready var wheel3 = $Robot/Legs/RobotLeg3/Wheel
@onready var wheel4 = $Robot/Legs/RobotLeg4/Wheel

@onready var antenneGroup = $Robot/TotalAntenne

@onready var animatedMouth = $AnimatedMouth

func _physics_process(delta):
	apply_gravity(delta)

	var input_axis = Input.get_axis("ui_left", "ui_right")

	handle_jump()
	handle_acceleration(input_axis, delta)
	apply_friction(input_axis, delta)

	move_and_slide()

	update_wheels(delta)
	update_antenna_rotation(delta)
	update_mouth_animation()


func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * movement_data.gravity_scale * delta


func handle_jump():
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = movement_data.jump_velocity


func handle_acceleration(input_axis, delta):
	if input_axis != 0:
		velocity.x = move_toward(
			velocity.x,
			movement_data.speed * input_axis,
			movement_data.acceleration * delta
		)


func apply_friction(input_axis, delta):
	if input_axis == 0 and is_on_floor():
		velocity.x = move_toward(
			velocity.x,
			0,
			movement_data.friction * delta
		)


func update_wheels(delta):
	var angular_speed = velocity.x / wheel_radius
	wheel1.rotation += angular_speed * delta
	wheel2.rotation += angular_speed * delta
	wheel3.rotation += angular_speed * delta
	wheel4.rotation += angular_speed * delta

func update_antenna_rotation(delta):
	var target = clamp(-velocity.x / movement_data.speed * max_angle, -max_angle, max_angle)
	
	# Simple spring-damper
	var stiffness = 50.0
	var damping = 10.0
	
	var force = (target - antenneGroup.rotation) * stiffness - rotation_velocity * damping
	rotation_velocity += force * delta
	antenneGroup.rotation += rotation_velocity * delta

func update_mouth_animation():
	if not is_on_floor():
		if animatedMouth.animation != "gasp":
			animatedMouth.play("gasp")
	else:
		if animatedMouth.animation != "smile": 
			animatedMouth.play("smile")

func _on_hazard_detector_area_entered(area):
	global_position = starting_position
