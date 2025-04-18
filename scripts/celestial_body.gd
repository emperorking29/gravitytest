class_name CelestialBody
extends RigidBody2D

@onready var universe: Node = %Universe

#@export var bodyRadius: float = 60
@export var bodyMass: float = 10
@export var bodyInitalVelocity: Vector2

var allBodies: Array[RigidBody2D]

var forceInfo


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# assign start 
	allBodies = getBodys(universe)
	linear_velocity = bodyInitalVelocity

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
	#


# formula for attraction
func updateVelocity(allBodies: Array[RigidBody2D], timeStep: float):
	for otherBody in allBodies:
		if otherBody != self:
			var distX: float = (otherBody.position.x - position.x)
			var distY: float = (otherBody.position.y - position.y)
			var dist: float = sqrt((distX*distX)+(distY*distY))
			var forceDir:Vector2 = (otherBody.position - position).normalized()
			var force: Vector2 = forceDir * universe.G * bodyMass * otherBody.bodyMass / dist
			var acceleration: Vector2 = force / bodyMass
			#currentVel += acceleration * timeStep
			linear_velocity += acceleration * timeStep
			
			forceInfo = force

# get all bodies from the universe
func getBodys(universe: Node) -> Array[RigidBody2D]:
	var bodies: Array[RigidBody2D]
	for body in universe.get_children():
		if body is CelestialBody:
			bodies.append(body)
	return bodies
