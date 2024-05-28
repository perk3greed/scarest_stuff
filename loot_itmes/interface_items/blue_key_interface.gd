extends MeshInstance3D


var rng = RandomNumberGenerator.new()


func _process(delta):
	var my_random_number = rng.randf_range( 0, 0.01)
	self.rotate_x(my_random_number)
	self.rotate_y(my_random_number)
	self.rotate_z(my_random_number)
