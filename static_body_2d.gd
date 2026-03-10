extends StaticBody2D

# Put this on the StaticBody2D
@onready var collision_poly = $CollisionPolygon2D
@onready var visual_poly = $Polygon2D

func _ready():
	visual_poly.polygon = collision_poly.polygon
	visual_poly.color = Color(0.5, 0.7, 1.0, 1.0)  # any color
