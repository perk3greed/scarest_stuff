extends LineEdit


signal lamp_light_changed(light_force)






func _on_text_submitted(new_text):
	Events.emit_signal("lamp_light_changed", new_text)
