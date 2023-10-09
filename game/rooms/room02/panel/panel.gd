extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _activate():
	var beamray = escoria.object_manager.get_object("beamray")
	escoria.event_manager.schedule_event(beamray.events["activate"], 0.5)
	#	escoria.globals_manager.set_global("portal_active", true)	
#	beamray.active = true
#	beamray.set_state("activate")			
	queue_free()

func _on_n_pressed():		
	escoria.object_manager.get_object("_sound").node.set_state("res://game/rooms/room02/sfx/ok.ogg")
	escoria.globals_manager.set_global("portal_correct_coordinates", true)
	_activate();		

func _on_ok_pressed():
	escoria.object_manager.get_object("_sound").node.set_state("res://game/rooms/room02/sfx/nop.ogg")
	_activate();
	
func _on_close_pressed():
#	escoria.main.current_scene.game.show_ui()
#	escoria.main.current_scene.show()	
	queue_free()
