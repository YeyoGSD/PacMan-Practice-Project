class_name Ghost extends CharacterBody2D

enum State {IDLE, CHASE}

@onready var navigation_agent:NavigationAgent2D = $NavigationAgent

var state:State : set = set_state
var speed:int = 160
var direction:Vector2
var target_position:Vector2

func set_state(new_state:State) -> void:
	state = new_state
	
	if state == State.IDLE:
		direction = Vector2.UP
		speed = 80
	elif state == State.CHASE:
		speed = 100

func _ready() -> void:
	state = State.IDLE

func _physics_process(_delta:float) -> void:
	velocity = direction * speed
	match state:
		State.IDLE:
			if move_and_slide():
				direction *= -1
		State.CHASE:
			chase()
			move_and_slide()

func chase() -> void:
	pass

func to_chase_state(new_target_position:Vector2) -> void:
	state = State.CHASE
	target_position = new_target_position
