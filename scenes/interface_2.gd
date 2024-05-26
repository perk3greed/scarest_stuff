extends Control

func _ready():
	Events.connect("change_print_output", print_stuff)


func print_stuff():
	$output.clear()
	var stuff_to_print = Events.printed_log
	$output.add_text(stuff_to_print)
	$Timer.start()
	



func _on_timer_timeout():
	$output.clear()
