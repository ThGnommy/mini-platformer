extends Control


@onready var global_vars = get_node("/root/Global")

@onready var label_diamonds = $Panel/HBoxContainer2/diamonds

@onready var label_key = $Panel/HBoxContainer/key

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	Global.connect("diamond_update", _on_diamond_update)
	Global.connect("key_taken", _on_key_taken)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_diamond_update(diamond_count: int): 
	label_diamonds.text = "{x} / {y}".format({"x": Global.diamonds_count, "y": Global.max_diamonds})

func _on_key_taken():
	var has_key = "1" if Global.player_has_key else "0"
	#var x = "coat" if raining else "t-shirt"
	label_key.text = "{x} / {y}".format({"x": has_key, "y": "1"})
