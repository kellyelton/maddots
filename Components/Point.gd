extends Node2D

class_name Point

const Electromagnetic_Power: float = 10.0
const Electromagnetic_Distance: float = 30.0
const StrongForce_Power: float = 100.0
const StrongForce_Distance: float = 8.0

export (Color) var color = Color.crimson
export (String) var type = "red"

var velocity = Vector2.ZERO

onready var istr: String = "_interact_with_" + self.type

var lines = []

func _ready():
	self.add_to_group("points")
	self.add_to_group(self.type + "_points")

func _process(delta):
	var vel = Vector2.ZERO
	lines.clear()
	for child in get_parent().get_children():
		if not child.is_in_group("points"): continue
		if child == self: continue
		if self.has_method(child.istr):
			var adj = self.call(child.istr, child, delta)
			
			if adj != Vector2.ZERO:
				vel += adj
	
	self.velocity = lerp(self.velocity, vel, 0.2)
	
	self.position += self.velocity * delta
	
	update()

func _draw():
	draw_circle(Vector2.ZERO, 1, color)
