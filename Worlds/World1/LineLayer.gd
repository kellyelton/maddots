extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var lines = []

func _draw():
	for line in lines:
		var start = line[0]
		var end = line[1]
		var color = line[2]
		draw_line(start, end, color, 1, true)
