extends Node
var musica: AudioStreamPlayer


func _ready() -> void:
	musica = AudioStreamPlayer.new()
	musica.stream = preload("res://Assets/music/music_for_video-just-relax-11157.mp3")
	musica.bus = "Music"
	musica.autoplay = true
	add_child(musica)
	musica.play()
	
