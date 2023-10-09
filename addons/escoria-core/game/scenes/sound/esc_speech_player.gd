# Speech player
extends Control
class_name ESCSpeechPlayer


# Global id of the background music player
export var global_id: String = "_speech"

# Reference to the audio player
onready var stream: AudioStreamPlayer = $AudioStreamPlayer


# Set the state of this player
#
# #### Parameters
#
# - p_state: New state to use
# - p_force: Override the existing state even if the stream is still playing
func set_state(p_state: String, p_force: bool = false) -> void:
	# If speech is disabled, return
	if not ESCProjectSettingsManager.get_setting(
		ESCProjectSettingsManager.SPEECH_ENABLED
	):
		return

	# If state is "off"/"default", turn off speech
	if p_state in ["off", "default"]:
		stream.stream = null
		return

	var resource = load(p_state)
	stream.stream = resource

	if stream.stream:
		stream.stream.set_loop(false)
		escoria.object_manager.get_object("_music").node.set_volume(-25)
		$AudioStreamPlayer.play()
		
#func _on_stream_completed():
#	escoria.object_manager.get_object("_music").node.set_volume(0)
		
# Register to the object registry
func _ready():
	pause_mode = Node.PAUSE_MODE_STOP
	escoria.object_manager.register_object(
		ESCObject.new(global_id, self),
		null,
		true
	)

func _restore_volume():	
	yield(get_tree().create_timer(1.5), "timeout")
	while escoria.object_manager.get_object("_music").node.get_volume() < 0:
		var vol = escoria.object_manager.get_object("_music").node.get_volume()
		escoria.object_manager.get_object("_music").node.set_volume(vol + 1)
		yield(get_tree().create_timer(0.1), "timeout")
	
# Callback called when the audio stream player finished playing.
func _on_AudioStreamPlayer_finished() -> void:	
	_restore_volume()
	set_state("off")


# Pause the speech player
func pause():
	stream.stream_paused = true


# Unpause the speech player
func resume():
	stream.stream_paused = false
