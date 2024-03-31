extends Control


func _ready():
	Events.connect("change_interace_visibility", change_self_vis)
	
	



func change_self_vis():
	if self.visible == true:
		self.visible = false
	elif self.visible == false:
		self.visible = true


