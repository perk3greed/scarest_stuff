extends AudioStreamPlayer3D

var random = RandomNumberGenerator.new()

func _ready():
	self.set_pitch_scale(random.randf_range(0.99, 1.01))

func play_sound_randomized():
	if (!playing):
		play()
