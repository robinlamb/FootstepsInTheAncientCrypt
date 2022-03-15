extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$Button.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().change_scene("res://game.tscn")


func _on_Button2_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$ColorRect2/btnBack.grab_focus()
	$ColorRect2.visible = true


func _on_btnBack_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$Button.grab_focus()
	$ColorRect2.visible = false
