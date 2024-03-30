extends Node


signal object_interacted_with(owner_of_node)
signal change_current_camera(floating)
signal light_turned_on
signal light_turned_off
signal lamp_light_changed(light_force)
signal lamp_distance_changed(lmp_dist)


var interacted_object 

var current_player_position : Vector3

var floating_camera_is_active : bool 
var lamp_level_selected : int
var amount_of_lamps_on : int 









