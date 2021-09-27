extends Node2D


# $ sign gets directory
func _ready():
	$MarginContainer/VBoxContainer/VBoxContainer/newGame.grab_focus()
	$MarginContainer/VBoxContainer/VBoxContainer/quit.grab_focus()

func _physics_process(delta):
	if $MarginContainer/VBoxContainer/VBoxContainer/newGame.is_hovered() == true:
		$MarginContainer/VBoxContainer/VBoxContainer/newGame.grab_focus()
	if $MarginContainer/VBoxContainer/VBoxContainer/quit.is_hovered() == true:
		$MarginContainer/VBoxContainer/VBoxContainer/quit.grab_focus()
	



func _on_newGame_pressed():
	get_tree().change_scene("Stage1.tscn")


func _on_quit_pressed():
	get_tree().quit()
