extends Sprite

var label = []
var index = 0
var firstSet = true # per non fare andare il suono la prima volta

# Called when the node enters the scene tree for the first time.
func _ready():
	for node in get_parent().get_children():
		if node is Label:
			label.append(node)
	setPosizione(0)
	firstSet = false
	
func setPosizione(n_index):
	if n_index >= 0 and n_index < len(label):
		index = n_index
		var selectedNode = label[index]
		
		var offSetX = (self.get_rect().size.x * self.scale.x)/2 + 10
		var offSetY = selectedNode.rect_size.y / 2
		
		self.position = Vector2(
			selectedNode.rect_position.x - offSetX,
			selectedNode.rect_position.y + offSetY
		)
		
		if not firstSet:
			$Suoni/Roll.play()

func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		setPosizione(index - 1)
	elif Input.is_action_just_pressed("ui_down"):
		setPosizione(index + 1)
	aggiornaColoreScritte()
	if Input.is_action_just_pressed("ui_accept"):
		$Suoni/Select.play()
		yield($Suoni/Select, "finished")
		label[index].effettuaAzione()

func aggiornaColoreScritte():
	for nodo in label:
		if nodo == label[index]:
			nodo.modulate.a = 1
		else:
			nodo.modulate.a = 0.3


