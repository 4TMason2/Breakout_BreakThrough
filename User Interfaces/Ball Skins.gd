extends Tabs

onready var price2 = str2var($RichTextLabel/Control/Panel2/Label.text)
onready var price3 = str2var($RichTextLabel/Control/Panel3/Label.text)
onready var price4 = str2var($RichTextLabel/Control/Panel4/Label.text)
onready var panels = $RichTextLabel/Control


func _ready():
	# Saves the bought item for the player
	Global.load_store()
	for item in range(panels.get_child_count() - 2):
		if Global.store.bought[item] == true:
			panels.get_node('Panel' + str(item + 1)).get_node('Button').text = 'Select'
	panels.get_node('Panel' + str(Global.store.selected + 1)).get_node('Button').text = 'Selected'
	panels.get_node('Panel' + str(Global.store.selected + 1)).get_node('Button').add_to_group('selected')
	

func _process(delta):
	$RichTextLabel/Control.position.x = -$HScrollBar.value

# Equips the selected skin from the shop
func selected(node,item_num):
	Global.load_store()
	for buttons in get_tree().get_nodes_in_group('selected'):
		buttons.text = 'Select'
		buttons.remove_from_group('selected')
	node.text = 'Selected'
	node.add_to_group('selected')
	Global.store.selected = item_num
	Global.save_store()

# Buys the item from the store
func buy(price, item_num):
	Global.load_store()
	
	# Checks if the player has bought the item or not
	if Global.store.bought[item_num] == false:
		
		# Checks if they have enough money
		if Global.points >= price:
			Global.points -= price
			Global.store.bought[item_num] = true
			panels.get_node('Panel' + str(item_num + 1)).get_node('Button').text = 'Select'
			Global.save_store()
		else:
			var rem = price - Global.points
			$NotEnough/Label.text = 'You need ' + str(rem) + ' more points to buy this'
			$NotEnough.show()
	else:
		selected(panels.get_node('Panel' + str(item_num + 1)).get_node('Button'), item_num)

func _on_Button4Buy_pressed():
	buy(price4, 3)


func _on_Button3Buy_pressed():
	buy(price3, 2)


func _on_Button2Buy_pressed():
	buy(price2, 1)

# Not enough points buttons
func _on_Button_pressed():
	$NotEnough.hide()

# Default skin button
func _on_DefaultButton_pressed():
	buy(0,0)
