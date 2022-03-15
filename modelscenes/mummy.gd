extends KinematicBody

export var walk_speed = 2
export var run_speed = 10
export var walk_turn_speed = 2
export var run_turn_speed = 10

var path = []
var cur_path_idx = 0
var velocity = Vector3.ZERO
var threshold = .1
var player
var turn_speed = walk_turn_speed
var target_location
var player_near = false
export var startingPoint = Vector3()
export var patrolEnd = Vector3()
var heading_to_end = true
var speed =  walk_speed

enum {
	PATROL,
	CHASE,
}

var state


onready var nav = get_parent()
onready var look_direction = $LookDirection

func _ready():
	player = get_tree().get_nodes_in_group("player")[0]
	change_state_patrol()
	
func _physics_process(delta):
	match state:
		PATROL:
			if heading_to_end:
				target_location = patrolEnd
			else:
				target_location = startingPoint
			
		CHASE:
			target_location = player.global_transform.origin
			
	if path.size() > 0:
		move_to_target(target_location)
	if !player_near:
		change_state_patrol()

	if player_near:
		if !player.light_on and !player.making_noise:
			change_state_patrol()
		else:
			change_state_chase()
		
func move_to_target(target_pos):
	look_direction.look_at(target_pos, Vector3.UP)
	rotate_y(deg2rad(look_direction.rotation.y * turn_speed))
	if global_transform.origin.distance_to(path[cur_path_idx]) < threshold:
		path.remove(0)
	else:
		var direction = path[cur_path_idx] - global_transform.origin
		velocity = direction.normalized() * speed
		move_and_slide(velocity, Vector3.UP)
		
func get_target_path(target_pos):
	path = nav.get_simple_path(global_transform.origin, target_pos)


func change_state_chase():
	state = CHASE
	speed = run_speed
	turn_speed = run_turn_speed

func change_state_patrol():
	state = PATROL
	speed = walk_speed
	turn_speed = walk_turn_speed
	
func _on_Timer_timeout():
	if state == CHASE:
		get_target_path(player.global_transform.origin)
	else:
		if heading_to_end:
			get_target_path(patrolEnd)
		else:
			get_target_path(startingPoint)


func _on_SensingRange_body_entered(body):
	if body.is_in_group("player"):
		player_near = true
		if player.light_on or player.making_noise:
			$ISeeYou.playing = true
			change_state_chase()



func _on_SensingRange_body_exited(body):
	if body.is_in_group("player"):
		player_near = false
	if state == CHASE:
		change_state_patrol()


func _on_ChangeDirection_timeout():
	if heading_to_end:
		heading_to_end = false
	else:
		heading_to_end = true
