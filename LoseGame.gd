extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$ColorRect/Button.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	get_tree().call_group("game", "start_new_game")
	get_tree().change_scene("res://game.tscn")



func _on_AudioStreamPlayer2_finished():
	$AudioStreamPlayer.playing = true
