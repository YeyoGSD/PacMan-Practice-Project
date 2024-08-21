class_name Player
extends CharacterBody2D

@onready var animation_player:AnimationPlayer = $AnimationPlayer
@onready var sprite:Sprite2D = $Sprite

signal collected_pellet

const SPEED:int = 150

var direction:Vector2

func _physics_process(_delta:float) -> void:
	input_movement()
	check_animation()
	move_and_slide()
	screen_wrap()

func input_movement() -> void:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * SPEED

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
