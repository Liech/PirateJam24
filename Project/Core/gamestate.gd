extends Node

enum Scenes {Godot, Triggerwarning, Ubiscene, Credits, StartScreen, MainMenu, LooseScreen, Options, Memories,ActualGame, KeyBinding, WinScreen, TermsAndServices, Limbo}

 
var twChoice = "Confusion";
var fadeouttime = 1.5;
var fadeintime = 1;
var masternode;
var currentSceneName = "Godot";
var currentScene;
var fader;
var nextScene = Scenes.MainMenu;
var snap;
var snapActive = false;
var snapPool;
var dialog;
var currentTab = "Gameplay"
var Postprocessor
var isfading = false
var playerpos;
var playerposstart;
var playerposinitialized = false
var catExplain = false;
var buttonLabel;
var popup;
var actNumber = 0;
var termsagreed = false
var musicPlayer;
var deleteHint;
var snapPanelCount = 0;
var limboscene = "Start Game"

func startScene(Scene : Scenes):
	if (Scene == Scenes.Godot):
		var scene = ResourceLoader.load("res://Scenes/GodotScreen/GodotScreen.tscn");
		currentScene = scene.instantiate();
		currentScene.set_name("Godot");
		snapActive= false
	elif (Scene == Scenes.Triggerwarning):
		var scene = ResourceLoader.load("res://Scenes/TriggerWarning/TriggerWarning.tscn")
		currentScene = scene.instantiate();
		currentScene.set_name("TriggerWarning");
		currentSceneName = "TriggerWarning";
		snapActive= false
	elif (Scene == Scenes.Ubiscene):
		var scene = ResourceLoader.load("res://Scenes/Ubiscene/Ubiscene.tscn")
		currentScene = scene.instantiate();
		currentScene.set_name("Ubiscene");
		currentSceneName = "Ubiscene";
		snapActive= false
	elif (Scene == Scenes.StartScreen):
		var scene = ResourceLoader.load("res://Scenes/StartScreen/StartScreen.tscn")
		currentScene = scene.instantiate();
		currentScene.set_name("StartScreen");
		currentSceneName = "StartScreen";
		snapActive= false
	elif (Scene == Scenes.Credits):
		var scene = ResourceLoader.load("res://Scenes/Credits/Credits.tscn")
		currentScene = scene.instantiate();
		currentScene.set_name("Credits");
		currentSceneName = "Credits";
		snapActive= true
	elif (Scene == Scenes.MainMenu):
		var scene = ResourceLoader.load("res://Scenes/MainMenu/MainMenu.tscn")
		currentScene = scene.instantiate();
		currentScene.set_name("MainMenu");
		currentSceneName = "MainMenu";
		snapActive= true
	elif (Scene == Scenes.LooseScreen):
		var scene = ResourceLoader.load("res://Scenes/LooseScreen/LooseScreen.tscn")
		currentScene = scene.instantiate();
		currentScene.set_name("LooseScreen");
		currentSceneName = "LooseScreen";
		snapActive= true
	elif (Scene == Scenes.WinScreen):
		var scene = ResourceLoader.load("res://Scenes/WinScreen/WinScreen.tscn")
		currentScene = scene.instantiate();
		currentScene.set_name("WinScreen");
		currentSceneName = "WinScreen";
		snapActive= true
	elif (Scene == Scenes.Options):
		var scene = ResourceLoader.load("res://Scenes/Options/Options.tscn")
		currentScene = scene.instantiate();
		currentScene.set_name("Options");
		currentSceneName = "Options";
		gamestate.currentTab = "Gameplay"
		snapActive= true
	elif (Scene == Scenes.Memories):
		var scene = ResourceLoader.load("res://Scenes/Memories/Memories.tscn")
		currentScene = scene.instantiate();
		currentScene.set_name("Memories");
		currentSceneName = "Memories";
		snapActive= true
	elif (Scene == Scenes.ActualGame):
		var scene = ResourceLoader.load("res://Scenes/ActualGame/ActualGame.tscn")
		currentScene = scene.instantiate();
		currentScene.set_name("ActualGame");
		currentSceneName = "ActualGame";
		snapActive = true
	elif (Scene == Scenes.KeyBinding):
		var scene = ResourceLoader.load("res://Scenes/Keybindings/Keybindings.tscn")
		currentScene = scene.instantiate();
		currentScene.set_name("Keybindings");
		currentSceneName = "Keybindings";
		snapActive = true
	elif (Scene == Scenes.TermsAndServices):
		var scene = ResourceLoader.load("res://Scenes/TermsAndServices/TermsAndServices.tscn")
		currentScene = scene.instantiate();
		currentScene.set_name("TermsAndServices");
		currentSceneName = "TermsAndServices";
		snapActive = true
	elif (Scene == Scenes.Limbo):
		var scene = ResourceLoader.load("res://Scenes/Limbo/Limbo.tscn")
		currentScene = scene.instantiate();
		currentScene.set_name("Limbo");
		currentSceneName = "Limbo";
		snapActive = false
		
	masternode.add_child(currentScene)
	return currentScene;


func fadeTo(sceneName : Scenes):
	isfading = true;
	var tween = create_tween();
	await tween.tween_property(fader,"modulate",Color(0,0,0,100),fadeouttime).finished
	currentScene.queue_free()
	gamestate.startScene(sceneName);
	var tween2 = create_tween();
	await tween2.tween_property(fader,"modulate",Color(0,0,0,0),fadeintime).finished
	isfading = false;


