extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		get_tree().call_group("game", "set_key_found")
		if get_parent().get_parent().visible:
			$AudioStreamPlayer3D.playing = true
		get_parent().get_parent().visible = false



func _on_AudioStreamPlayer3D_finished():
	get_parent().get_parent().queue_free()
