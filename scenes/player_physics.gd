extends CharacterBody3D

var speed
const WALK_SPEED = 4
const SPRINT_SPEED = 8
const JUMP_VELOCITY = 9
var sensitivity = 0.01
const sprint_time :float = 99
var current_sprint :float = 0
var shotgun_ammo :int = 200
var current_recoil_active_pb : bool = false
var current_recoil_active_shotgun : bool = false
var shotgun_shot_active : bool = false
var recoil_count : float = 0 

var pb_shot_active : bool = false
var pb_magazine :int = 8
var pb_ammo : int = 260
var pb_ads : bool = false
var bp_magazine_max_capacity : int = 8
var pb_magazine_difference : int

var is_crouching = false
var movement_multiplier = 1.0

var sword_owned :bool = false
var shotgun_owned :bool = false
const BOB_FREQ = 2.4
const BOB_AMP = 0.08
var t_bob = 0.0

const BASE_FOV = 75.0
const FOV_ZOOM = 30.0
const FOV_CHANGE = 1.0

const raycast_hit_point = preload("res://stuff/raycast_hit.tscn")
var rng = RandomNumberGenerator.new()
var gravity = 18

var maxHorizontalOffset = 5
var maxVerticalOffset = 5
var target_pos
var default_target_pos
var light_on : bool = false
var current_weapon : String 
var current_inv_item : int 


var floating_camera_active : bool = false
var flying_active : bool = false

@onready var head = $Head
@onready var camera = $Head/camera_crane
@onready var gun_raycast = $Head/camera_crane/gun_raycast
var interact_prompt : bool
@onready var real_camera =$Head/camera_crane/Camera3D
@onready var hand_raycast = $Head/camera_crane/hand_raycast
@onready var upcheck = $upcheck/RayCast3D
@onready var collision = $player_cl

signal action_use_pressed
signal object_interacted_with(owner_of_node)
signal item_scrolled_up
signal item_scrolled_down

func _ready():
	Events.connect("change_current_camera", change_camera_to_floating)
	Events.player_rid = get_rid()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$Head/SubViewportContainer.size = DisplayServer.window_get_size()

func _process(delta):
	if Input.is_action_just_pressed("F"):
		if light_on == true:
			$Head/camera_crane/SpotLight3D.light_energy = 0
			light_on = false
		elif light_on == false:
			$Head/camera_crane/SpotLight3D.light_energy = 3
			light_on = true
	
	if Input.is_action_just_pressed("L"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if Input.is_action_just_pressed("K"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	if Input.is_action_just_pressed("I"):
		sensitivity -= 0.005
	
	if Input.is_action_just_pressed("O"):
		sensitivity += 0.005
	
	if Input.is_action_just_pressed("6"):
		if flying_active == false:
			flying_active = true
		elif flying_active == true:
			flying_active = false
	
	if Input.is_action_just_pressed("5"):
		if flying_active == true:
			velocity.y -= JUMP_VELOCITY
	
	if Input.is_action_just_pressed("4"):
		if flying_active == true:
			velocity.y += JUMP_VELOCITY
	
	camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-80), deg_to_rad(85))
	camera.rotation.y = 0

func _unhandled_input(event):	
	if Events.floating_camera_is_active == true:
		return
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * sensitivity*0.1)
		camera.rotate_x(-event.relative.y * sensitivity*0.1)

func _physics_process(delta):
	Events.current_player_position = self.global_position
	
	if Events.floating_camera_is_active == true:
		return
	
	# crouching
	if Input.is_action_just_pressed("crouch"):
		upcheck.force_raycast_update()
		if is_crouching and not upcheck.is_colliding():
			is_crouching = false
		elif not is_crouching:
			is_crouching = true
		if not upcheck.is_colliding():
			if is_crouching:
				print("beginning crouch")
				movement_multiplier = 0.5
				collision.scale.y = 0.5
				collision.position.y = 0.559 - 0.5
				head.position.y = 1.643 - 0.5
			elif not is_crouching:
				print("ending crouch")
				movement_multiplier = 1.0
				collision.scale.y = 1.0
				collision.position.y = 0.559
				head.position.y = 1.643
	
	hand_raycast.force_raycast_update()
	var hand_touched_what = hand_raycast.get_collider()
	var hand_touched_where = hand_raycast.get_collision_point()
	
	if hand_touched_what != null:
		$laser_pointer.position = hand_touched_where
		#print(hand_touched_what)
		if hand_touched_what.is_in_group("object"):
			interact_prompt = true
		else :
			interact_prompt = false
	else:
		interact_prompt = false
	
	if not is_on_floor():
		if flying_active == false:
			velocity.y -= gravity * delta
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if Input.is_action_pressed("SHIFT"):
		if sprint_time > current_sprint:
			current_sprint += delta
			speed = SPRINT_SPEED * movement_multiplier
		else :
			speed = WALK_SPEED * movement_multiplier
	else:
		speed = WALK_SPEED * movement_multiplier
		if current_sprint > 0:
			current_sprint -= delta
	
	if Input.is_action_just_pressed("scroll down"):
		Events.emit_signal("item_scrolled_down")
	if Input.is_action_just_pressed("scroll up"):
		Events.emit_signal("item_scrolled_up")
	
	if Input.is_action_just_pressed("E"):
		var hand_tousched = $Head/camera_crane/hand_raycast.get_collision_point()
		if hand_touched_what != null:
			#print(hand_touched_what)
			if hand_touched_what.is_in_group("object"):
				hand_touched_what.interact()
				Events.emit_signal("object_interacted_with", hand_touched_what)
	
	var input_dir = Input.get_vector("A", "D", "W", "S")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 7.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 7.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 3.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 3.0)

	# Head bob
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(t_bob)
	
	# FOV
	var velocity_clamped = clamp(Vector2(velocity.x, velocity.z).length(), 0.5, SPRINT_SPEED * 2)
	var target_fov = BASE_FOV + FOV_CHANGE * velocity_clamped
	if Input.is_action_pressed("zoom"): #zoomy zooms
		target_fov = FOV_ZOOM
	real_camera.fov = lerp(real_camera.fov, target_fov, delta * 8.0)
	
	move_and_slide()
	
	for index in get_slide_collision_count():
		var collided_with_parent = get_slide_collision(index)
		var collided_with = collided_with_parent.get_collider()
		if collided_with.is_in_group("decor"):
			var collision_point = - self.global_position + collided_with_parent.get_position()
			var collsion_speed = - self.velocity + collided_with_parent.get_collider_velocity(index)
			var csn = collsion_speed.normalized()*0.3
			collided_with.apply_impulse(csn,collision_point)
	


func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos
	

func change_camera_to_floating(floating):
	if floating == true:
		$Head/camera_crane/Camera3D.current = false
		Events.floating_camera_is_active = true

	elif floating == false:
		$Head/camera_crane/Camera3D.current = true
		Events.floating_camera_is_active = false


