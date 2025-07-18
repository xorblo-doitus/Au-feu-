extends Node2D

@onready var burning_wheat: Node2D = $BurningWheat


func _ready():
	burning_wheat.burnable_area.lit = true
	pass


@warning_ignore("unused_parameter")
func _process(delta):
	
	pass
