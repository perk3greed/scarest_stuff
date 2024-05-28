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
signal item_scrolled_down
signal item_scrolled_up
signal display_inventory_item
signal clear_inventory_scroll

var interacted_object 
var current_requirement : String 
var current_requirement_amount : int 
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
	add_item_to_inventory("hand")


func add_item_to_inventory(item):
	var item_string = str(item)
	if player_inventory.has(item):
		player_inventory[item_string] += 1
		print(player_inventory)
	else :
		player_inventory[item_string] = 1
		print(player_inventory)


var inventory_array : Array
var inv_size : int
var current_active_array_place : float


func show_inventory_scroll():
	
	inventory_array = Events.player_inventory.keys()
	inv_size = inventory_array.size()
	current_active_array_place = 0.5
	Events.emit_signal("display_inventory_item")


func _process(delta):
	if Input.is_action_just_pressed("scroll down"):
		if current_active_array_place > 0:
			current_active_array_place -= 0.5
			Events.emit_signal("item_scrolled_down")
			print(current_active_array_place)
	if Input.is_action_just_pressed("scroll up"):
		if current_active_array_place < inv_size:
			current_active_array_place += 0.5
			Events.emit_signal("item_scrolled_up")
			print(current_active_array_place)



