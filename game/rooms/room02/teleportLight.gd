extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _setLightActive(state):
	var light = get_node("../Sprite")
	var material = light.material
	var shader = material.shader
	var hasParam = shader.has_param("cutoff")
	material.set_shader_param("cutoff", 0.112)	
