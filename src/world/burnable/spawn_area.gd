@tool
extends Path2D


@export_range(1, 2**31) var gen_seed: int = 1234:
	set(new):
		gen_seed = new
		generate()
@export_range(0.01, 100) var object_approx_radius: float = 100:
	set(new):
		object_approx_radius = new
		generate()
@export var packed_scene: PackedScene
@warning_ignore("unused_private_class_variable")
@export_tool_button("Regenerate", "RandomNumberGenerator") var __ = generate

@export var spawn_cap: int = 1000


var _random_generator: RandomNumberGenerator


func generate() -> void:
	if not is_node_ready():
		return
	
	for child in get_children():
		child.queue_free()
	
	if packed_scene == null:
		return
	
	print("Regenerating ", self, "...")
	_random_generator = RandomNumberGenerator.new()
	_random_generator.seed = gen_seed
	
	var points: PackedVector2Array = PackedVector2Array()
	for i in curve.point_count:
		points.push_back(curve.get_point_position(i))
	var triangle_indices := Geometry2D.triangulate_polygon(points)
	var spawn_count: int = 0
	@warning_ignore("integer_division")
	for i in len(triangle_indices)/3:
		var i_a: int = i*3
		var a: Vector2 = points[triangle_indices[i_a]]
		var b: Vector2 = points[triangle_indices[i_a+1]]
		var c: Vector2 = points[triangle_indices[i_a+2]]
		
		for ___ in int(triangle_area(a, b, c) / object_approx_radius**2):
			var spawned: Node2D = packed_scene.instantiate()
			spawned.position = random_triangle_point(a, b, c)
			spawned.request_ready()
			add_child(spawned)
			spawn_count += 1
			if spawn_count >= spawn_cap:
				push_warning("Spawn cap reached on", self)
				return
	
	print("Regenerated ", self)


func random_triangle_point(a: Vector2, b: Vector2, c: Vector2) -> Vector2:
	return a + sqrt(_random_generator.randf()) * (-a + b + _random_generator.randf() * (c - b))
	
func triangle_area(a: Vector2, b: Vector2, c: Vector2) -> float:
	# shoelace formula
	return (
		a.x * b.y
		- b.x * a.y
		+ b.x * c.y
		- c.x * b.y
		+ c.x * a.y
		- a.x * c.y
	) / 2


func _draw() -> void:
	if Engine.is_editor_hint() and curve.point_count >= 3:
		generate()
		draw_line(
			curve.get_point_position(0),
			curve.get_point_position(curve.point_count-1),
			Color.SKY_BLUE,
		)



func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray = PackedStringArray()
	if packed_scene == null:
		warnings.push_back("Scene to instantiate is not defined.")
	return warnings
