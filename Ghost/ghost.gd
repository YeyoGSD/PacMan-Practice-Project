class_name Ghost extends CharacterBody2D

enum State {IDLE, CHASE}

var state:State : set = set_state
var speed:int = 160
var direction:Vector2

func set_state(new_state:State) -> void:
	var previous_state:State = state
	state = new_state
	
	if state == State.IDLE:
		direction = Vector2.UP
		speed = 80
	elif state == State.CHASE:
		direction = Vector2.RIGHT
		speed = 160

func _ready() -> void:
	state = State.IDLE

func _physics_process(delta) -> void:
	velocity = direction * speed
	match state:
		State.IDLE:
			if move_and_slide():
				direction *= -1
		State.CHASE:
			chase()

func chase() -> void:
	pass

func to_chase_state() -> void:
	state = State.CHASE
