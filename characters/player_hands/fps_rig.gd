extends Node3D



@onready var camera_parent = $".."
var blue_key_hud = preload("res://loot_itmes/interface_items/blue_key_interface.tscn")
var red_key_hud = preload("res://loot_itmes/interface_items/red_key_interface.tscn")
var hand = preload("res://loot_itmes/interface_items/interface_hand.tscn")
var distant_x_pos : float = -0.5
var inv_scroll_shown : bool = false

var positions_dict : Dictionary = {
	0 : Vector3(distant_x_pos , 1.5, 3),
	1 : Vector3(distant_x_pos , 1.1, 3),
	2 : Vector3(distant_x_pos , 0.7, 3),
	3 : Vector3(distant_x_pos , 0.3, 3),
	4 : Vector3(distant_x_pos , -0.1, 3)
	
}

var inv_menu_dict : Dictionary = {
	0 : Vector3(1 , 1.5, 3),
	1 : Vector3(0 , 1.5, 3),
	2 : Vector3(-1 , 1.5, 3),
	3 : Vector3(4 , 0.3, 3),
	4 : Vector3(5 , -0.1, 3)
	
	
}






func _ready():
	Events.connect("item_scrolled_down", scroll_inv_hud_down)
	Events.connect("item_scrolled_up", scroll_inv_hud_up)
	Events.connect("display_inventory_item", display_inv_hud)
	Events.connect("clear_inventory_scroll", clear_hud_scrl)


func clear_hud_scrl():
	if inv_scroll_shown == true:
		for child in $inventory.get_children():
			child.queue_free()
			inv_scroll_shown = false

func _process(delta):
	if Input.is_action_just_pressed("r"):
		if Events.inv_menu_open == true:
			for child in $inventory.get_children():
				child.queue_free()
			Events.inv_menu_open = false
		else:
			for child in $inventory.get_children():
				child.queue_free()
			var inv_hud_size = Events.inv_size
			Events.inv_menu_open = true
			for i in inv_hud_size:
				var current_item_name = Events.inventory_array[i]
				match current_item_name:
				
					"key_blue":
						var blue_key_instance = blue_key_hud.instantiate()
						$inventory.add_child(blue_key_instance)
						blue_key_instance.position = inv_menu_dict[i]
				
					"red_key":
						var red_key_instance = red_key_hud.instantiate()
						$inventory.add_child(red_key_instance)
						red_key_instance.position = inv_menu_dict[i]
		
					"hand":
						var hand_instance = hand.instantiate()
						$inventory.add_child(hand_instance)
						hand_instance.position = inv_menu_dict[i]



func scroll_inv_hud_up():
	if Events.inv_menu_open == true:
		return
	for child in $inventory.get_children():
		child.position.y += 0.2

		
	for child in $inventory.get_children():
		if child.position.y > 1.6 and child.position.y < 1.8:
			child.position.x = -0.2
		else :
			child.position.x = distant_x_pos




func scroll_inv_hud_down():
	if Events.inv_menu_open == true:
		return
	for child in $inventory.get_children():
		child.position.y -= 0.2

	for child in $inventory.get_children():
		if child.position.y > 1.6 and child.position.y < 1.8:
			child.position.x = -0.2
		else :
			child.position.x = distant_x_pos









func display_inv_hud():
	inv_scroll_shown = true
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








