extends Node3D


var player_position 
var amount_of_lights_turned_on : int = 0 



var rng = RandomNumberGenerator.new()

@onready var navigation_reg = $"SubViewportContainer2/SubViewport/SubViewportContainer/SubViewport/3dworld/level/NavigationRegion3D"
@onready var enemies = $"SubViewportContainer2/SubViewport/SubViewportContainer/SubViewport/3dworld/level/NavigationRegion3D/enemies"
@onready var player = $"SubViewportContainer2/SubViewport/SubViewportContainer/SubViewport/3dworld/player"
@onready var floating_camera = $"SubViewportContainer2/SubViewport/SubViewportContainer/SubViewport/3dworld/light_menu_camera"
@onready var amount_lights_turned_on_text = $SubViewportContainer2/SubViewport/SubViewportContainer/SubViewport/Control/amount_of_lapms

var current_camera_floating : bool

signal change_current_camera



func _ready():
	Events.connect("light_turned_on", increase_turned_on_lights)
	Events.connect("light_turned_off", decrease_turned_on_lights)


func _process(delta):
	if Input.is_action_just_pressed("u"):
		if current_camera_floating == false: 
			current_camera_floating = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		elif current_camera_floating == true :
			current_camera_floating = false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		Events.emit_signal("change_current_camera" ,current_camera_floating)
	
	
	if current_camera_floating == true:
		if Input.is_action_pressed("W"):
			floating_camera.position.z -= 0.5
		if Input.is_action_pressed("S"):
			floating_camera.position.z += 0.5
		if Input.is_action_pressed("A"):
			floating_camera.position.x -= 0.5
		if Input.is_action_pressed("D"):
			floating_camera.position.x += 0.5
	
	
	
	player_position = player.global_position
	
	
	Events.floating_camera_is_active = current_camera_floating





func increase_turned_on_lights():
	amount_of_lights_turned_on += 1
	Events.amount_of_lamps_on = amount_of_lights_turned_on
	
	amount_lights_turned_on_text.text = str(Events.amount_of_lamps_on)

func decrease_turned_on_lights():
	amount_of_lights_turned_on -= 1
	Events.amount_of_lamps_on = amount_of_lights_turned_on
	amount_lights_turned_on_text.text = str(Events.amount_of_lamps_on)

