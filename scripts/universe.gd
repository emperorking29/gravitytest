extends Node

const G: float = 10 # gravitational constant
var allBodies: Array[RigidBody2D]

@onready var label: Label = $Label

func _ready() -> void:
	# get all bodies
	for body in get_children():
		if body is CelestialBody:
			allBodies.append(body)


func _physics_process(delta: float) -> void:
	# calculate all bodies
	for body in allBodies:
		body.updateVelocity(allBodies, delta)
		label.text = "Force Vector: " + str(body.forceInfo)
		
	
	
	
