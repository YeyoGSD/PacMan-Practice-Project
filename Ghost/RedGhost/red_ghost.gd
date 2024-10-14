extends Ghost

func chase() -> void:
	navigation_agent.target_position = target_position
	direction = (navigation_agent.get_next_path_position() - global_position).normalized()
