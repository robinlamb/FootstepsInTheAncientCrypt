extends SpotLight
export (Resource) var bookPlace1


var can_use = true

func _ready():
	get_tree().call_group("player", "set_light_on", true)

func _input(event):
	if Input.is_key_pressed(KEY_F) or Input.is_joy_button_pressed(0, JOY_L):
		if can_use:
			can_use = false
			visible = !visible
			if visible:
				play_sound(bookPlace1, -10)
				get_tree().call_group("player", "set_light_on", true)
			else:
				play_sound(bookPlace1, -10)
				get_tree().call_group("player", "set_light_on", false)
	else:
		can_use = true

func play_sound(sound, volume):
	var audio_node = AudioStreamPlayer.new()
	add_child(audio_node)
	audio_node.stream = sound
	audio_node.volume_db = volume
	audio_node.pitch_scale = rand_range(0.95, 1.05)
	audio_node.play()
	yield(audio_node, "finished")
	audio_node.queue_free()
