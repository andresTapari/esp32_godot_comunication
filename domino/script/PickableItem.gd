extends TextureRect

var follow_mouse = true
var placeable = false

var place_holder_target
var cmd: String = ""

var normal_texture: Texture = null
var hover_texture: Texture = null

func _process(delta: float) -> void:
	if follow_mouse:
		self.rect_position = get_viewport().get_mouse_position()-Vector2(32,32)

func _input(event: InputEvent) -> void:
	if event.is_action_released("mouse_loose"):
		follow_mouse = false
		if place_holder_target:
			placeable = true
			place_holder_target.texture_normal = normal_texture
			place_holder_target.texture_hover = hover_texture
			place_holder_target.cmd = cmd
		queue_free()

func _on_Area2D_area_entered(area: Area2D) -> void:
	place_holder_target = area.get_parent()
	visible = false

func _on_Area2D_area_exited(area: Area2D) -> void:
	place_holder_target = null
	visible = true
