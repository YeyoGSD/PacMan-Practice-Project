extends Node2D

@onready var player:Player = $Player
@onready var red_ghost:Ghost = $Ghosts/RedGhost

func _on_player_collected_pellet():
	pass

func _on_red_timer_timeout() -> void:
	red_ghost.to_chase_state(player.global_position)
