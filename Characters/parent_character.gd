class_name ParentCharacter extends CharacterBody2D

@export var move_speed: float
@export var health: float

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var sprite = $Sprite2D

func walk(input_direction: Vector2):
	print("Method not Implemented")


func update_animation_parameters(move_input : Vector2):
	print("Method not Implemented")
	
	
func pick_new_animation_state():
	print("Method not Implemented")
