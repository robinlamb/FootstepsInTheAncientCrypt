extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var door = preload("res://modelscenes/egyptiandoor.tscn")
var doorkey = preload("res://modelscenes/key.tscn")
var door_instance
var key_instance
var door_y_position = 1.8
var door_x_position
var door_z_position
var key_y_position = 1
var key_x_position
var key_z_position
var key_found = false

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("game")
	door_instance = door.instance()
	add_child(door_instance)
	placeDoor()
	place_key()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func placeDoor():

	randomize()
	var doorWall = randi() % 4
	randomize()
	
	if doorWall == 0:
		door_z_position = 49.0
		door_x_position = float(randi() % 94 - 47)
	elif doorWall == 1:
		door_z_position = -49
		door_x_position = float(randi() % 94 - 47)
		door_instance.set_rotation_degrees(Vector3(0, 180, 0))
	elif doorWall == 2:
		door_x_position = 49
		door_z_position = float(randi() % 94 - 47)
		door_instance.set_rotation_degrees(Vector3(0, 90, 0))
	else:
		door_x_position = -49
		door_z_position = float(randi() % 94 - 47)
		door_instance.set_rotation_degrees(Vector3(0, -90, 0))
	
	door_instance.transform.origin = Vector3(door_x_position, door_y_position, door_z_position)
	
func place_key():
	key_instance = doorkey.instance()

	randomize()
	key_x_position = float(randi() % 96 - 48)
	randomize()
	key_z_position = float(randi() % 96 - 48)
	
	key_instance.transform.origin = Vector3(key_x_position, key_y_position, key_z_position)
	add_child(key_instance)

func lose_game():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene("res://LoseGame.tscn")

func try_game_again():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$Player.transform.origin = Vector3(33.0, 0.664, 21.0)

func set_key_found():
	key_found = true
	$txtKey.visible = true

func check_door():
	if key_found:
		$DoorOpens.playing = true
	else:
		$DoorClosed.playing = true


func start_new_game():
	placeDoor()
	place_key()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$Player.transform.origin = Vector3(33.0, 0.664, 21.0)


func _on_Area_area_entered(area):
	print("key entered")
	if area.is_in_group("key"):
		key_instance.queue_free()
		place_key()
		print("key location change")


func _on_DoorOpens_finished():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene("res://WinGame.tscn")
