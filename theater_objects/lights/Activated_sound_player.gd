extends AudioStreamPlayer3D

var random = RandomNumberGenerator.new()
var sounds = [
"res://sounds_n_music/lampochka_activate_0.ogg",
"res://sounds_n_music/lampochka_activate_1.ogg",
"res://sounds_n_music/lampochka_activate_2.ogg",
"res://sounds_n_music/lampochka_activate_3.ogg"]

func _ready():
	self.set_pitch_scale(random.randf_range(0.95, 1.05))

func play_sound_randomized():
	if (!playing):
		stream = load(sounds[random.randi_range(0, len(sounds) - 1)])
		play()
