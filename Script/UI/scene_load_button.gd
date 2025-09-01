extends Button

@export var scene_path = ""

func _ready():
	disabled = scene_path == ""
	
func _on_pressed():
	SceneManager.load_scene(scene_path)
