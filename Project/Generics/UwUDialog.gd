extends Control
class_name UwUDialog

@export var characterName : String
@export var characterBelly : String
@export var characterIcon : int
@export var ears : bool


var dialogActive = false
var currentBlock;

var earleftoffset = Vector2(44,50);
var earrightoffset = Vector2(44,50);

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func choiceMade(choice):
	closeDialog()

func startup():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	handleChoiceConnection()
	if (get_parent() is CheckBox):
		handleCheckboxConnection()
	elif (get_parent() is Button):
		handleButtonConnection()
	elif (get_parent() is HSlider):
		handleHSliderConnection()
	elif(get_parent() is OptionButton):
		handleOptionsButtonConnection();
	
	if (ears):
		$"Graphics/Left".position.x = get_parent().position.x - earleftoffset.x
		$"Graphics/Right".position.x = get_parent().position.x + Vector2(get_parent().size.x,0.0).x -earrightoffset.x
		$"Graphics/Left".visible = isUwU()
		$"Graphics/Right".visible = isUwU()
	
func setTextBlock(block):
	gamestate.dialog.setText(block.text);
	gamestate.dialog.setChoices(block.choices)
	currentBlock = block
	
func closeDialog():
	gamestate.dialog.closeDialog()
	dialogActive = false
	
func startDialog():
	gamestate.dialog.openDialog()
	gamestate.dialog.setCharacterName(characterName)
	gamestate.dialog.setBelly(characterBelly)
	setTextBlock(get_child(1))
	dialogActive = true
	
	if (characterIcon == 1):
		gamestate.dialog.setCharacter(gamestate.dialog.Bodies.ButtonChan);
	elif (characterIcon == 0):
		gamestate.dialog.setCharacter(gamestate.dialog.Bodies.Nothing);
	startup()
	
func handleChoiceConnection():
	var dialogCon = gamestate.dialog.is_connected("choiceMade",choiceMade)
	if ((not dialogActive) and dialogCon):
		gamestate.dialog.disconnect("choiceMade",choiceMade)
	if (dialogActive and not dialogCon):
		gamestate.dialog.connect("choiceMade",choiceMade)	
	
func handleCheckboxConnection():
	var dialogOpen= gamestate.dialog.dialogActive
	if (dialogOpen):
		return;
	var UwUOnline = get_parent().is_connected("toggled",_on_toggled)
	var ParOnline = get_parent().is_connected("toggled",get_parent()._on_toggled)
	var uwu = isUwU()
	
	if (uwu and ParOnline):
		get_parent().disconnect("toggled",get_parent()._on_toggled)
	if (uwu and not UwUOnline):
		get_parent().connect("toggled",_on_toggled)
	if (not uwu and UwUOnline):
		get_parent().disconnect("toggled",_on_toggled)
	if (not uwu and not ParOnline):
		get_parent().connect("toggled",get_parent()._on_toggled)
	pass
	
func handleOptionsButtonConnection():
	var dialogOpen= gamestate.dialog.dialogActive
	if (dialogOpen):
		return;
	var UwUOnline = get_parent().is_connected("toggled",_on_toggled)
	var ParOnline = get_parent().is_connected("toggled",get_parent()._on_toggled)
	var uwu = isUwU()
	
	if (uwu and ParOnline):
		get_parent().disconnect("toggled",get_parent()._on_toggled)
	if (uwu and not UwUOnline):
		get_parent().connect("toggled",_on_toggled)
	if (not uwu and UwUOnline):
		get_parent().disconnect("toggled",_on_toggled)
	if (not uwu and not ParOnline):
		get_parent().connect("toggled",get_parent()._on_toggled)
	pass
	

func handleHSliderConnection():
	var dialogOpen= gamestate.dialog.dialogActive
	if (dialogOpen):
		return;
	var UwUOnline = get_parent().is_connected("drag_started",_on_pressed)
	var ParOnline = get_parent().is_connected("drag_started",get_parent()._on_drag_started)
	var uwu = isUwU()
	
	if (uwu and ParOnline):
		get_parent().disconnect("drag_started",get_parent()._on_drag_started)
		get_parent().disconnect("value_changed",get_parent()._on_value_changed)
	if (uwu and not UwUOnline):
		get_parent().connect("drag_started",_on_pressed)
	if (not uwu and UwUOnline):
		get_parent().disconnect("drag_started",_on_pressed)
	if (not uwu and not ParOnline):
		get_parent().connect("drag_started",get_parent()._on_drag_started)
		get_parent().connect("value_changed",get_parent()._on_value_changed)
	pass
	
	
func handleButtonConnection():
	var dialogOpen= gamestate.dialog.dialogActive

	if (dialogOpen):
		return;
	var UwUOnline = get_parent().is_connected("pressed",_on_pressed)
	var ParOnline = get_parent().is_connected("pressed",get_parent()._on_pressed)
	var uwu = isUwU()
	
	if (uwu and ParOnline):
		get_parent().disconnect("pressed",get_parent()._on_pressed)
	if (uwu and not UwUOnline):
		get_parent().connect("pressed",_on_pressed)
	if (not uwu and UwUOnline):
		get_parent().disconnect("pressed",_on_pressed)
	if (not uwu and not ParOnline):
		get_parent().connect("pressed",get_parent()._on_pressed)
		
func isUwU():
	return GlobalOptions.localization == GlobalOptions.Localization.UwU

func nextBlock():
	var next = currentBlock.get_index()+1
	setTextBlock(currentBlock.get_parent().get_child(next))

func _on_toggled(toggled_on):
	startDialog();

func _on_pressed():
	startDialog();
