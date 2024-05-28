extends Node3D



@onready var camera_parent = $".."
var current_item_number
var previous_item_number
var blue_key_hud = preload("res://loot_itmes/interface_items/blue_key_interface.tscn")
var red_key_hud = preload("res://loot_itmes/interface_items/red_key_interface.tscn")
var hand = preload("res://loot_itmes/interface_items/interface_hand.tscn")
var distant_x_pos : float = -0.5


var positions_dict : Dictionary = {
	0 : Vector3(distant_x_pos , 1.5, 3),
	1 : Vector3(distant_x_pos , 1.1, 3),
	2 : Vector3(distant_x_pos , 0.7, 3),
	3 : Vector3(distant_x_pos , 0.3, 3),
	4 : Vector3(distant_x_pos , -0.1, 3)
	
}

func _ready():
	Events.connect("item_scrolled_down", scroll_inv_hud_down)
	Events.connect("item_scrolled_up", scroll_inv_hud_up)
	Events.connect("display_inventory_item", display_inv_hud)


func _process(delta):
	pass


func scroll_inv_hud_up():
	for child in $inventory.get_children():
		child.position.y += 0.2

		
	for child in $inventory.get_children():
		if child.position.y > 1.6 and child.position.y < 1.8:
			child.position.x = -0.2
		else :
			child.position.x = distant_x_pos




func scroll_inv_hud_down():
	for child in $inventory.get_children():
		child.position.y -= 0.2

	for child in $inventory.get_children():
		if child.position.y > 1.6 and child.position.y < 1.8:
			child.position.x = -0.2
		else :
			child.position.x = distant_x_pos









func display_inv_hud():
	for child in $inventory.get_children():
		child.queue_free()
	
	var inv_hud_size = Events.inv_size
	for i in inv_hud_size:
		var current_item_name = Events.inventory_array[i]
		match current_item_name:
			
			"key_blue":
				var blue_key_instance = blue_key_hud.instantiate()
				$inventory.add_child(blue_key_instance)
				blue_key_instance.position = positions_dict[i]
			
			"red_key":
				var red_key_instance = red_key_hud.instantiate()
				$inventory.add_child(red_key_instance)
				red_key_instance.position = positions_dict[i]
	
			"hand":
				var hand_instance = hand.instantiate()
				$inventory.add_child(hand_instance)
				hand_instance.position = positions_dict[i]
	
	
	
	for child in $inventory.get_children():
		if child.position.y > 1.6 and child.position.y < 1.8:
			child.position.x = -0.2
		else :
			child.position.x = distant_x_pos








