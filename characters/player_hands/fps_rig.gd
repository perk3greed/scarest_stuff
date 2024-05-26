extends Node3D


var rng = RandomNumberGenerator.new()
@onready var camera_parent = $".."
var current_item_number
var previous_item_number


func _ready():
	
	
	Events.connect("item_scrolled_up", scroll_hud_up)
	Events.connect("item_scrolled_down", scroll_hud_down)
	

	

func _process(delta):
	var my_random_number = rng.randf_range( 0, 0.01)
	$inventory/Cube_006_Material_001_0.rotate_x(my_random_number)
	$inventory/Cube_006_Material_001_0.rotate_y(my_random_number)
	$inventory/Cube_006_Material_001_0.rotate_z(my_random_number)

func scroll_hud_up():
	var amount_of_items = $inventory.get_child_count()
	for child in amount_of_items:
		var current_operant = $inventory.get_child(child)
		current_operant.position.y += 0.1

func scroll_hud_down():
	var amount_of_items = $inventory.get_child_count()
	for child in amount_of_items:
		var current_operant = $inventory.get_child(child)
		current_operant.position.y -= 0.1
