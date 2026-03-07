extends Control

@onready var music: AudioStreamPlayer = $Musica
@onready var options_panel: PanelContainer = $PanelContainer
@onready var music_slider: HSlider = $PanelContainer/VBoxContainer/HBoxContainer/SliderVolumen
@onready var sfx_slider: HSlider = $PanelContainer/VBoxContainer/HBoxContainer2/SliderEfectos
@onready var fullscreen_btn: CheckButton = $PanelContainer/VBoxContainer/FullScreen

func _ready() -> void:
	
	
	options_panel.hide()
	music_slider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
	sfx_slider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX"))
	fullscreen_btn.button_pressed = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN

# ── Botones del menú principal ──
func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/calle.tscn")

func _on_opciones_pressed() -> void:
	options_panel.show()

func _on_exit_pressed() -> void:
	get_tree().quit()

# ── Panel de opciones ──
func _on_volver_pressed() -> void:
	options_panel.hide()

func _on_slider_volumen_value_changed(value: float) -> void:
	
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)

func _on_slider_efectos_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)

func _on_full_screen_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
