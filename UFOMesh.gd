extends ImmediateGeometry


func _ready():
	self.begin(VS.PRIMITIVE_LINE_LOOP, null)

	self.add_vertex(Vector3(1.9, -0.4, 0.0)) # Far left edge Bottom line
	self.add_vertex(Vector3(0.7, 0.4, 0.0)) # Top line left edge
	self.add_vertex(Vector3(0.3, 1.1, 0.0))
	self.add_vertex(Vector3(-0.3, 1.1, 0.0))
	self.add_vertex(Vector3(-0.7, 0.4, 0.0)) # Top line right edge
	self.add_vertex(Vector3(-1.9, -0.4, 0.0)) # Right edge bottom line
	self.add_vertex(Vector3(-0.8, -1.1, 0.0))
	self.add_vertex(Vector3(0.8, -1.1, 0.0))

	self.end()

	self.begin(VS.PRIMITIVE_LINES, null)

	self.add_vertex(Vector3(0.7, 0.4, 0.0)) # Top line
	self.add_vertex(Vector3(-0.7, 0.4, 0.0))
	self.add_vertex(Vector3(1.9, -0.4, 0.0)) # Bottom line
	self.add_vertex(Vector3(-1.9, -0.4, 0.0))

	self.end()
