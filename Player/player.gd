class_name Player
extends CharacterBody2D

@onready var animation_player:AnimationPlayer = $AnimationPlayer
@onready var sprite:Sprite2D = $Sprite
@onready var down_ray_cast:RayCast2D = $WallsDetectors/DownRayCast
@onready var up_ray_cast:RayCast2D = $WallsDetectors/UpRayCast
@onready var right_ray_cast:RayCast2D = $WallsDetectors/RightRayCast
@onready var left_ray_cast:RayCast2D = $WallsDetectors/LeftRayCast

signal collected_pellet

const SPEED:int = 150

var current_direction:Vector2
var desired_direction:Vector2
var new_direction:Vector2

func _physics_process(_delta:float) -> void:
	input_movement()
	check_animation()
	move_and_slide()
	screen_wrap()

func input_movement() -> void:
	new_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if new_direction:
		desired_direction = new_direction
	if can_move(desired_direction):
		current_direction = desired_direction
	velocity = current_direction * SPEED

func can_move(direction:Vector2) -> bool:
	if direction.x < 0:
		return !left_ray_cast.is_colliding()
	elif desired_direction.x > 0:
		return !right_ray_cast.is_colliding()
	elif desired_direction.y < 0:
		return !up_ray_cast.is_colliding()
	else:
		return !down_ray_cast.is_colliding()

func check_animation() -> void:
	if velocity:
		if velocity.x:
			sprite.flip_h = (velocity.x < 0)
		animation_player.play("walk")
	else:
		animation_player.pause()

func screen_wrap() -> void:
	global_position.x = wrapf(global_position.x, 8, Global.viewport_size.x - 8)

func _on_collection_area_area_entered(_area:Area2D) -> void:
	collected_pellet.emit()
