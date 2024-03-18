extends CanvasLayer

class_name ui
signal game_started

@onready var end_of_game_screen = $end_screen


func _on_restart_button_pressed():
	get_tree().reload_current_scene()
