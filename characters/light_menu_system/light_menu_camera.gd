extends Node3D

var floating : bool

const RAY_LENGTH = 160



func _ready():
	Events.connect("change_current_camera" ,change_camera)
	
	


func _process(delta):
	#if Input.is_action_pressed("ui_text_scroll_up"):
		#print("stuff")
		#self.position.x += 1
	#if Input.is_action_pressed("ui_text_scroll_down"):
		#print("stuff")
		#self.position.x -= 1
	pass

func change_camera(floating):
	if floating == false:
		$Camera3D.current = false
	elif floating == true:
		$Camera3D.current = true


func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		var camera3d = $Camera3D
		var from = camera3d.project_ray_origin(event.position)

		$light_cast.position = from
		$light_cast.force_raycast_update()
		var light_selected = $light_cast.get_collider()
		if light_selected != null:
			light_selected.light_lamp_clicked()
		else:
			print("null")
		
		
