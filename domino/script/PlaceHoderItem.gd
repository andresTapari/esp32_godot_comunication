extends TextureButton

# Señales:
signal itemListAdded						# Señal emitida cuando se carga un item

# Nodos:
onready var ICON = preload('res://scenes/ui_control/pickable_item.tscn')	# Icono por defecto

# Constanes:
onready var DEFAULT_TEXTURE = preload("res://assets/vector/domino_icons/blanc_icon.png")
onready var DEFAULT_CMD = ""

# Variables:
var available = true						# Bandera si esta ocupado
var cmd: String = ""						# Comando
var default_texture: Texture				# Textura por defecto
var default_cmd: String 					# Comando por defecto

func _ready() -> void:
	default_texture = texture_normal

func _on_Area2D_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("item"):
		self.texture_normal = area.get_parent().texture

func _on_Area2D_area_exited(area: Area2D) -> void:
	if area.get_parent().is_in_group("item"):
		if !area.get_parent().placeable:
			texture_normal = default_texture
			texture_hover = default_texture
			cmd = default_cmd
		else:
			available = false
			cmd = area .get_parent().cmd
			default_texture = texture_normal
			default_cmd = cmd
			emit_signal("itemListAdded")

func _on_TextureButton_button_down():
	if !available:
		var newIcon = ICON.instance()
		newIcon.cmd = cmd
		newIcon.texture = texture_normal
		newIcon.normal_texture = texture_normal
		newIcon.hover_texture = texture_hover
		get_node("/root/Node2D/MainLvl").add_child(newIcon)
		default_texture = DEFAULT_TEXTURE
		default_cmd = DEFAULT_CMD
		available = true
