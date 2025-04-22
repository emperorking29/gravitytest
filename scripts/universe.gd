extends Node

const G: float = 10 # gravitational constant
var allBodies: Array[RigidBody2D]

@onready var label: Label = $Label
var velx: int
var vely: int

func _ready() -> void:
	# get all bodies
	for body in get_children():
		if body is CelestialBody:
			allBodies.append(body)
			
	# stop time
	Engine.time_scale = 0;


func _on_line_edit_text_changed(new_text: String) -> void:
	velx = int(new_text)

func _on_line_edit_2_text_changed(new_text: String) -> void:
	vely = int(new_text)




# start simulation when pressed
func _on_button_pressed() -> void:
	for body in get_children():
		if body.name == "SmallBody":
			var smallBody = body
			smallBody.linear_velocity.x = velx
			smallBody.linear_velocity.y = vely
	Engine.time_scale = 1;
	
# reset scene
func _on_button_2_pressed() -> void:
	get_tree().reload_current_scene()
	
func _physics_process(delta: float) -> void:
	# calculate all bodies
	for body in allBodies:
		body.updateVelocity(allBodies, delta)
		label.text = "Force Vector: " + str(body.forceInfo)
		
	
	
	
