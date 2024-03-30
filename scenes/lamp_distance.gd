extends LineEdit


signal lamp_distance_changed(lmp_dist)




func _on_text_submitted(new_text):
	var new_var = int(new_text)
	Events.emit_signal("lamp_distance_changed", new_var)
