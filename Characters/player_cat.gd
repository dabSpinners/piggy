extends CharacterBody2D

@export var move_speed: float = 50
@export var run_multiplier: float = 2
@export var dash_multiplier: float = 25

@export var starting_direction: Vector2 = Vector2(0, 1)

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

func _ready():
	update_animation_parameters(starting_direction)
	
func _physics_process(_delta):
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	update_animation_parameters(input_direction)
	moving_system(input_direction)
	pick_new_animation_state()
	
func moving_system(input_direction: Vector2):
	if (Input.is_action_pressed('shift')):
		velocity = input_direction * move_speed * run_multiplier
	else:
		velocity = input_direction * move_speed
	
	if (Input.is_action_just_pressed("space")):
		velocity = input_direction * move_speed * dash_multiplier
		
	move_and_slide()
	
func update_animation_parameters(move_input : Vector2):
	if (move_input != Vector2.ZERO):
		animation_tree.set("parameters/Walk/blend_position", move_input)
		animation_tree.set("parameters/Idle/blend_position", move_input)

func pick_new_animation_state():
	if(velocity != Vector2.ZERO):
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")
