# `set_gui_visible visible`
#
# Show or hide the GUI.
#
# **Parameters**
#
# - *visible*: Whether the GUI should be visible (`true` or `false`)
#
# @ESC
extends ESCBaseCommand
class_name SetCinematicModeCommand


# Return the descriptor of the arguments of this command
func configure() -> ESCCommandArgumentDescriptor:
	return ESCCommandArgumentDescriptor.new(
		1,
		[TYPE_BOOL],
		[null]
	)


# Run the command
func run(command_params: Array) -> int:
	if command_params[0]:
#		escoria.main.current_scene.game.hide_ui()
		escoria.main.set_cinematic_mode(true)		
	else:
#		escoria.main.current_scene.game.show_ui()
		escoria.main.set_cinematic_mode(false)		
	return ESCExecution.RC_OK


# Function called when the command is interrupted.
func interrupt():
	# Do nothing
	pass
