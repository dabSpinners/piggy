extends ParentCharacter

@export var run_multiplier: float = 2
@export var dash_multiplier: float = 25

@export var starting_direction: Vector2 = Vector2(0, 1)

func _init():
	move_speed = 50
	health = 10
	
func _ready():
	update_animation_parameters(starting_direction)
	
func _physics_process(_delta):
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	update_animation_parameters(input_direction)
	walk(input_direction)
	pick_new_animation_state()
	
func walk(input_direction: Vector2):
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
		
