extends Node3D


@export var lamp_level : int
var working : bool = false
var lamp_disct_current : int = 180 

@export var turned_on : bool = true

var already_blinked : bool = false

signal light_turned_on
signal light_turned_off


func _ready():
	self.visible= true
	Events.connect("change_current_camera" ,change_camera)
	Events.connect("lamp_light_changed", adjust_light_force)
	Events.connect("lamp_distance_changed", adjust_lamp_distance)
	Events.connect("light_turned_on", light_on_sound)


func _physics_process(delta):
	var space_state = get_world_3d().direct_space_state
	var current_player_spot = Events.current_player_position
	var bruh_x = (current_player_spot.x - self.global_position.x)
	var bruh_y = (current_player_spot.y - self.global_position.y)
	var bruh_z = (current_player_spot.z - self.global_position.z)
	var bruh_x_pow2 = pow(bruh_x, 2)
	var bruh_y_pow2 = pow(bruh_y, 2)
	var bruh_z_pow2 = pow(bruh_z, 2)
	var distance_to_player = bruh_x_pow2  + bruh_y_pow2 + bruh_z_pow2
	var lower_or_higher = current_player_spot.y - self.global_position.y
	
	if turned_on == false:
		$CSGBox3D.visible = false
		$OmniLight3D.visible = false
	elif turned_on == true:
		if distance_to_player > lamp_disct_current:
			already_blinked = false
			$OmniLight3D.visible = false
			$CSGBox3D.visible = false
			$Buzz_sound_player.stop()
		elif distance_to_player < lamp_disct_current:
			if lower_or_higher < 0:
				var query = PhysicsRayQueryParameters3D.create(
					global_position,
					Events.current_player_position,
					0b1,
					[Events.player_rid])
				# 0b1 mask to only have the layer 1 mask and not the default all
				# as the player is in layer 2, this should hopefully only give wall
				# collisions.
				var result = space_state.intersect_ray(query)
				if (result.is_empty()):
					$OmniLight3D.visible = true
					$CSGBox3D.visible = true
					if (!already_blinked):
						already_blinked = true
						light_on_sound()

func update_state():
	if turned_on == false:
		Events.emit_signal("light_turned_off")
		$light_map_menu.visible = false
		$light_map_menu2.visible = true
	elif turned_on == true:
		Events.emit_signal("light_turned_on")
		$light_map_menu.visible = true
		$light_map_menu2.visible = false
	print(self , turned_on)



func change_light_state():
	if turned_on == true:
		turned_on = false
		update_state()
		
	elif turned_on == false:
		turned_on = true
		update_state()
	


func adjust_light_force(light_power):
	$OmniLight3D.omni_range = int(light_power)

func adjust_lamp_distance(lamp_dist):
	lamp_disct_current = lamp_dist



func change_camera(current):
	pass
	#if lamp_level == Events.lamp_level_selected :
		#$light_map_menu.visible = true
	#else :
		#$light_map_menu.visible = false

func light_on_sound():
	$Activated_sound_player.play_sound_randomized()
	$Buzz_sound_player.play_sound_randomized()
