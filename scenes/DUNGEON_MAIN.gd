extends Node3D


var player_position 

var rng = RandomNumberGenerator.new()

@onready var navigation_reg = $"SubViewportContainer2/SubViewport/SubViewportContainer/SubViewport/3dworld/level/NavigationRegion3D"
@onready var enemies = $"SubViewportContainer2/SubViewport/SubViewportContainer/SubViewport/3dworld/level/NavigationRegion3D/enemies"
@onready var player = $"SubViewportContainer2/SubViewport/SubViewportContainer/SubViewport/3dworld/player"



var current_camera_floating : bool


signal change_current_camera

func _ready():
#	Events.connect("change_weapons",check_player_weapons)
	Events.connect("give_player_money", give_player_money_func)


func _process(delta):
	if Input.is_action_just_pressed("u"):
		if current_camera_floating == false: 
			current_camera_floating = true
		elif current_camera_floating == true :
			current_camera_floating = false
		Events.emit_signal("change_current_camera" ,current_camera_floating)
	
	
	player_position = player.global_position
	
	

func give_player_money_func(how_much_money):
	Events.player_money += how_much_money

