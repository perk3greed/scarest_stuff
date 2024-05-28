extends StaticBody3D

var moving : bool = false
var moved_dist : float 
@export var moving_x_positive : bool 
@export var moving_z_positive : bool 
@export var moving_x_negative : bool 
@export var moving_z_negative : bool 
@export var needed_item : String 
@export var amount_of_items : int



signal change_print_output

func interact():
	if moved_dist >= 120:
		return
	
	moving = true
	Events.player_inventory[needed_item] -= amount_of_items



	#if Events.player_inventory.has(needed_item):
		#if Events.player_inventory[needed_item] >= amount_of_items:
			#moving = true
			#Events.player_inventory[needed_item] -= amount_of_items
			#print(Events.player_inventory)
		#else:
			#print("not enought items")
			#Events.printed_log = "not enought items!"
			#Events.emit_signal("change_print_output")
	#else :
		#print("no such item")
		#Events.printed_log = "no such item!"
		#Events.emit_signal("change_print_output")

func _process(delta):
	if moving == true:
		if moved_dist < 120:
			if moving_x_positive == true:
				self.position.x += 0.03
				moved_dist += 1
			if moving_z_positive == true:
				self.position.z += 0.03
				moved_dist += 1  
			if moving_x_negative == true:
				self.position.x -= 0.03
				moved_dist += 1  
			if moving_z_negative == true:
				self.position.z -= 0.03
				moved_dist += 1  



func check_requirement():
	Events.current_requirement = needed_item
	Events.current_requirement_amount = amount_of_items




