extends Node3D


@export var lamp_level : int
var working : bool = false
@export var turned_on : bool = true

signal light_turned_on
signal light_turned_off


func _ready():
	self.visible= true
	Events.connect("change_current_camera" ,change_camera)

func _physics_process(delta):
	
	
	
	
	var current_player_spot = Events.current_player_position
#You use the function pow(a, b) which is equivalent to a ** b.
#sqrt( (x1-x2)^2 + (y1-y2)^2 + (z1-z2)^2 )
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
		if distance_to_player > 180:
			$OmniLight3D.visible = false
			$CSGBox3D.visible = false
		elif distance_to_player < 180:
			if lower_or_higher < 0:
				$OmniLight3D.visible = true
				$CSGBox3D.visible = true




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
	








func change_camera(current):
	pass
	#if lamp_level == Events.lamp_level_selected :
		#$light_map_menu.visible = true
	#else :
		#$light_map_menu.visible = false

