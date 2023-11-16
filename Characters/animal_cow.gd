extends ParentCharacter

enum COW_STATE { IDLE, WALK }

@export var idle_time: float = 5
@export var walk_time: float = 2

@onready var timer = $Timer

var move_direction: Vector2 = Vector2.ZERO
var current_state: COW_STATE = COW_STATE.IDLE

func _init():
	move_speed = 20

func _ready():
	select_new_direction()
	pick_new_state()
	
func _physics_process(_delta):
	walk(Vector2.ZERO)
	
func walk(input_direction: Vector2):
	if(current_state == COW_STATE.WALK):
		velocity = move_direction * move_speed
		move_and_slide()
	
func select_new_direction():
	move_direction = Vector2(
		randi_range(-1, 1),
		randi_range(-1, 1)
	)
	
	flip_sprite()
	
	
func pick_new_state():
	if(current_state == COW_STATE.IDLE):
		state_machine.travel("Walk")
		current_state = COW_STATE.WALK
		select_new_direction()
		timer.start(walk_time)
	elif(current_state == COW_STATE.WALK):
		state_machine.travel("Idle")
		current_state = COW_STATE.IDLE
		timer.start(idle_time)
		
		
func flip_sprite():
	if(move_direction.x < 0):
		sprite.flip_h = true
	else:
		sprite.flip_h = false


func _on_timer_timeout():
	pick_new_state()
