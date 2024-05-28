extends RigidBody3D

signal add_item
signal change_print_output

func interact():
	Events.emit_signal("add_item", "red_key")
	Events.printed_log = "red key added!"
	Events.emit_signal("change_print_output")
	self.queue_free()
