extends Node


signal object_interacted_with(owner_of_node)
signal change_current_camera(floating)
signal light_turned_on
signal light_turned_off
signal lamp_light_changed(light_force)
signal lamp_distance_changed(lmp_dist)
signal change_interace_visibility
signal add_item(item)
signal change_print_output
signal item_scrolled_up
signal item_scrolled_down

var interacted_object 

var current_player_position : Vector3
var player_rid : RID

var floating_camera_is_active : bool 
var lamp_level_selected : int
var amount_of_lamps_on : int 

var current_inventory_item : int 

var printed_log : String

var player_inventory : Dictionary = {
	
	
	
}

func _ready():
	Events.connect("add_item", add_item_to_inventory)



func add_item_to_inventory(item):
	var item_string = str(item)
	if player_inventory.has(item):
		player_inventory[item_string] += 1
		print(player_inventory)
	else :
		player_inventory[item_string] = 1
		print(player_inventory)







