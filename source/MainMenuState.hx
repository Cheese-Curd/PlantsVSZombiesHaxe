package;

import flixel.util.FlxSave;
import flixel.addons.ui.FlxUIInputText;
import flixel.text.FlxText;
import flixel.util.FlxTimer;
import AngelUtils; // for masking and reading json lol
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

using flixel.util.FlxSpriteUtil;

#if windows
import discord_rpc.DiscordRpc;
#end

class MainMenuState extends FlxState
{
	// background stuff \\
	var selectMenu:FlxSprite;
	var tree:FlxSprite;
	var sky:FlxSprite;
	var backdrop:FlxSprite;
	var background:FlxSprite;
	// Options Menu \\
	var optionsMenu:FlxSpriteGroup;
	var optionsBG:FlxSprite;
	var optionsOk:FlxButton;
	var optionsOkText:FlxText;
	var optionsOkTextShadow:FlxText;
	var optionsOpen = false;
	// Options \\
	var musicVolume:Float;
	var soundVolume:Float;

	// Select Menu Buttons \\
	/* ==Menu Button Pathss==
		Adventure Start: 'assets/images/menu/mainmenu/SelectorScreen_StartAdventure_Button1.png'
		Adventure Start Shadow: 'assets/images/menu/mainmenu/SelectorScreen_Shadow_StartAdventure.png'
		Adventure: 'assets/images/menu/mainmenu/SelectorScreen_Adventure_Button.png'
		Adventure Shadow: 'assets/images/menu/mainmenu/SelectorScreen_Shadow_Adventure.png'
	 */
	var _gamedata:FlxSave;
	var adventure:FlxButton;
	var adventure_shadow:FlxSprite;
	var minigame:FlxButton;
	var minigame_shadow:FlxSprite;
	// Pot Buttons \\
	var options:FlxButton;
	var help:FlxButton;
	var quit:FlxButton;
	// Funny Wood \\
	var woodName:FlxSprite;
	var woodUsrSwitch:FlxButton;
	var woodUsrName:FlxText;
	var woodBroken:FlxSprite;
	// var name:String = 'No Name'; // will change I swear

	override public function create()
	{
		super.create();
	
		FlxG.sound.music.pause(); // for when transitioning back from help
		if (FlxG.sound.music.playing)
		{
			FlxG.sound.music.resume();
		}
		else
		{
			FlxG.sound.music.play();
		}

		// Initializing Game Save
		_gamedata = new FlxSave();
		_gamedata.bind("Save");

		// wood buttons \\

		woodName = new FlxSprite(22, -8).loadGraphic('assets/images/menu/mainmenu/SelectorScreen_WoodSign1.png');
		woodUsrSwitch = new FlxButton(25, 126);
		woodUsrSwitch.loadGraphic('assets/images/menu/mainmenu/ScreenSelector_WoodSign_Button.png', true, 291, 71);
		woodUsrName = new FlxText(147, 86);
		woodUsrName.setFormat('assets/fonts/Brianne_s_hand.ttf', 18, 0xFFF5C8, CENTER); // WHY IS THE E DIFFERENTTTTTTTTTTTTTTTTTT
		woodUsrName.text = "Unknown!"; // We don't have a name yet
		woodBroken = new FlxSprite(32, 179).loadGraphic('assets/images/menu/mainmenu/SelectorScreen_WoodSign3.png');

		// Options Menu \\

		optionsMenu = new FlxSpriteGroup();
		optionsOk = new FlxButton(29, 380, "", closeOptions);
		optionsOk.loadGraphic('assets/images/menu/mainmenu/options_backtogamebutton_full.png', true, 360, 100);
		optionsBG = AngelUtils.fromAlphaMask('assets/images/menu/options_menuback.jpg', 'assets/images/menu/options_menuback_.png', 0, 0);
		trace('Options Menu Shit loaded');
		FlxG.sound.play('assets/sounds/roll_in.ogg');
		background = new FlxSprite();
		background.makeGraphic(800, 600, FlxColor.WHITE);


		DiscordRpc.start({
			clientID: "884169727415566417",
			onReady: onReady,
			onError: onError,
			onDisconnected: onDisconnected
		});
		DiscordRpc.presence({
			details: 'Version: [PRIVATE BETA 2]',
			state: 'In the Main Menu.',
			largeImageKey: 'discord_rpc_512',
			largeImageText: 'Plants VS Zombies: Haxe Edition'
		});

		// Plays the Main Menu Theme (Dave Intro) \\
		// FlxG.sound.playMusic('assets/music/main_menu_theme.ogg');

		// Background Shit \\
		sky = new FlxSprite().loadGraphic('assets/images/menu/mainmenu/SelectorScreen_BG.jpg');
		add(background);
		// Stupid masking because the actual images are jpegs and not pngs >:c \\

		selectMenu = AngelUtils.fromAlphaMask('assets/images/menu/mainmenu/SelectorScreen_BG_Right.jpg',
			'assets/images/menu/mainmenu/SelectorScreen_BG_Right_.png', 71, 41); // VSCode what the fuck is wrong with you

		tree = AngelUtils.fromAlphaMask('assets/images/menu/mainmenu/SelectorScreen_BG_Left.jpg', 'assets/images/menu/mainmenu/SelectorScreen_BG_Left_.png',
			0, -80);

		backdrop = AngelUtils.fromAlphaMask('assets/images/menu/mainmenu/SelectorScreen_BG_Center.jpg',
			'assets/images/menu/mainmenu/SelectorScreen_BG_Center_.png', 103, 250);

		add(sky);
		add(backdrop);
		sky.setGraphicSize(800, 600);
		sky.updateHitbox();

		add(tree);
		add(selectMenu); // thank you Angel for helping me to get the masks to work, and for the Utils <3
		backdrop.setGraphicSize(778, 350); // not exact, but close
		// selectMenu.y = 40;
		// selectMenu.x = 70;
		add(woodName);
		add(woodUsrSwitch);
		add(woodBroken);
		add(woodUsrName);
		// Get the Select Menu Buttons \\
		getButtons();
		trace('[SYSTEM] tried loading buttons');
		doShit();
		trace("Doing shit?");
	}

	var nameTitle:FlxText;
	var nameSubTitle:FlxText;
	var nameInput:FlxUIInputText;
	var nameSubmit:FlxButton;

	function doShit()
	{
		trace('Animation not finished.');

		if (_gamedata.data.name == null)
		{
			nameTitle = new FlxText(337.5, 241);
			nameTitle.setFormat('assets/fonts/DWARVESC.ttf', 24, 0xFFF5C8, CENTER);
			nameTitle.y -= 45;
			nameTitle.text = 'new user';
			nameSubTitle = new FlxText(279, 275);
			nameSubTitle.setFormat('assets/fonts/DWARVESC.ttf', 18, 0xFFF5C8, CENTER);
			nameSubTitle.y -= 25;
			nameSubTitle.text = 'Please enter your name:';

			nameInput = new FlxUIInputText(350, 289, 100, '');
			nameInput.setFormat('assets/fonts/DWARVESC.ttf', 18, 0xFFF5C8, CENTER);
			nameInput.maxLength = 12;
			
			// VScode likes to lie about this line, it does actually work.
			nameInput.color = 0x000000; // Even though the UI isn't finished, make it so you can at least read it! (I was very lazy 3 years ago) - Eliana

			nameSubmit = new FlxButton(288, 320, 'Ok', submitName);

			add(nameTitle);
			add(nameSubTitle);
			add(nameInput);
			add(nameSubmit);
		}

		trace("Continuing to main Function.");
	}

	function submitName()
	{
		_gamedata.data.name = nameInput.text;
		nameInput.maxLength = 13;
		woodUsrName.text = _gamedata.data.name + '!';
		trace('Set name to ' + _gamedata.data.name);

		// Remove the UI
		remove(nameTitle);
		remove(nameSubTitle);
		remove(nameInput);
		remove(nameSubmit);

		_gamedata.flush(); // Save the name
	}

	function getButtons()
	{
		trace('[SYSTEM] loaded button function');
		// Adventure Button \\
		adventure = new FlxButton(405, 65, "", openAdventure);
		// game data \\
		trace("[SYSTEM] trying to load game save data...");
		if (_gamedata.data.newgame == null)
		{
			trace("[GAME DATA] Failed!"); 

			_gamedata.data.newgame = true;
			_gamedata.data.world = 1;
			_gamedata.data.level = 1;
			_gamedata.data.minigames = false;
			_gamedata.data.survival = false;
			_gamedata.data.fastpool = false;
			_gamedata.data.name = null; // Player has no name, we have to get it whenever the prompt appears

			_gamedata.flush();
			trace("[GAME DATA] Reset back to default.");
		}
		if (_gamedata.data.newgame == true)
		{
			adventure.loadGraphic('assets/images/menu/mainmenu/SelectorScreen_StartAdventure_Button1.png', true, 331, 146);
			adventure_shadow = new FlxSprite().loadGraphic('assets/images/menu/mainmenu/SelectorScreen_Shadow_StartAdventure.png');
		}
		else
		{
			adventure.loadGraphic('assets/images/menu/mainmenu/SelectorScreen_Adventure_button.png', true, 331, 146);
			adventure_shadow = new FlxSprite().loadGraphic('assets/images/menu/mainmenu/SelectorScreen_Shadow_Adventure.png');
		}
		adventure_shadow.x = 399;
		adventure_shadow.y = 65;
		trace('[SYSTEM] adventure button');
		// Mini-Games Button \\
		minigame = new FlxButton(405, 65, "", openMinigames);
		minigame.loadGraphic('assets/images/menu/mainmenu/SelectorScreen_Survival_button.png', true, 313, 133);
		minigame_shadow = new FlxSprite().loadGraphic('assets/images/menu/mainmenu/SelectorScreen_Shadow_Survival.png');
		minigame.y = 173;
		minigame.x = 406;
		minigame_shadow.x = 407;
		minigame_shadow.y = 177;
		if (_gamedata.data.minigames == false)
		{
			minigame.color = 0xFF808080;
		}
		trace('[SYSTEM] Mini-Games button');

		add(adventure_shadow);
		add(minigame_shadow);
		add(adventure);
		add(minigame);

		// Pot Buttons \\
		trace('[SYSTEM] started Pot Button collection...');
		options = new FlxButton(565, 490, "", optionsShit);
		options.loadGraphic('assets/images/menu/mainmenu/SelectorScreen_Options.png', true, 81, 31);
		help = new FlxButton(647, 529, "", helpShit);
		help.loadGraphic('assets/images/menu/mainmenu/SelectorScreen_Help.png', true, 46, 22);
		quit = new FlxButton(720, 515, "", quitShit);
		quit.loadGraphic('assets/images/menu/mainmenu/SelectorScreen_Quit.png', true, 45, 27);
		add(options);
		add(help);
		add(quit);
		trace('[SYSTEM] finished get buttons function');
	}

	function openAdventure()
	{
		FlxG.sound.play('assets/sounds/gravebutton.ogg'); // button sound
		fuckYouStop();
		if (_gamedata.data.newgame == true)
		{
			trace("[SYSTEM] New Adventure");
		}
		else
		{
			trace("[SYSTEM] Resume Adventure");
		}

		trace("[SYSTEM] Animation not finished!");

		FlxG.sound.music.stop();
		FlxG.sound.play('assets/sounds/losemusic.ogg');
		new FlxTimer().start(1.5, (tmr:FlxTimer) ->
		{
			FlxG.sound.play('assets/sounds/evillaugh.ogg');
		});

		new FlxTimer().start(6.5, (tmr:FlxTimer) ->
		{
			FlxG.switchState(new PlayState());
		});
	}

	function openMinigames()
	{
		FlxG.sound.play('assets/sounds/gravebutton.ogg'); // button sound
		if (_gamedata.data.minigames == true)
		{
			trace("[SYSTEM] MiniGame Unlocked");
			FlxG.switchState(new MinigameState());
		}
		else
		{
			trace("[SYSTEM] MiniGame Locked");
			FlxG.switchState(new MinigameState());
		}
	}

	function fuckYouStop()
	{
		minigame.active = false;
		adventure.active = false;
		quit.active = false;
		help.active = false;
		options.active = false;
	}

	function optionsShit()
	{
		FlxG.sound.play('assets/sounds/tap.ogg'); // button sound
		// optionsBG.loadGraphic('assets/images/menu/options_menuback.jpg'); // bg :c
		trace('[OPTIONS MENU] Is the options Menu Open? ' + optionsOpen);
		if (optionsOpen == false)
		{
			creatingMenu = true;
			optionsOpen = true;
			fuckYouStop();
			optionsMenu.add(optionsBG);
			optionsMenu.add(optionsOk);
			add(optionsMenu);
			optionsMenu.screenCenter();
			new FlxTimer().start(0.1, (tmr:FlxTimer) ->
			{
				creatingMenu = false;
			});
		}
	}

	function closeOptions()
	{
		optionsOpen = false;
		minigame.active = true;
		adventure.active = true;
		quit.active = true;
		help.active = true;
		options.active = true;
		FlxG.sound.play('assets/sounds/buttonclick.ogg'); // button sound
		optionsMenu.x = 0;
		optionsMenu.y = 0;
		remove(optionsMenu);
	}

	function helpShit()
	{
		FlxG.sound.play('assets/sounds/tap.ogg'); // button sound
		FlxG.sound.music.stop();
		new FlxTimer().start(0.2, (tmr:FlxTimer) ->
		{
			FlxG.switchState(new HelpState());
		});
	}

	function quitShit()
	{
		FlxG.sound.play('assets/sounds/tap.ogg'); // button sound
		// !!IMPORTANT: GET A MENU BEFORE CLOSING!! \\
		lime.system.System.exit(0);
	}

	// thanks Angel // Angel: no problem bud
	var draggingMenu:Bool = false;
	var creatingMenu:Bool = false;
	var menuPrevX:Float;
	var menuPrevY:Float;
	var cursorPrevX:Int;
	var cursorPrevY:Int;

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		// keep it running when it's alive and kill it when it's not?????? \\
		DiscordRpc.process();
		if (false)
		{
			DiscordRpc.shutdown();
		}
		// thanks Angel // Angel: no problem my dude
		if (FlxG.mouse.justPressed)
		{
			if (optionsOpen && !creatingMenu)
			{
				// optionsBG < click
				// optionsMenu < move

				var inButtonArea:Bool = false;
				var x1, x2, y1, y2;
				x1 = optionsOk.getScreenPosition().x;
				x2 = optionsOk.getScreenPosition().x + optionsOk.width;
				y1 = optionsOk.getScreenPosition().y;
				y2 = optionsOk.getScreenPosition().y + optionsOk.height;
				if (FlxG.mouse.screenX >= x1 && FlxG.mouse.screenX <= x2 && FlxG.mouse.screenY >= y1 && FlxG.mouse.screenY <= y2)
					inButtonArea = true;

				if (!inButtonArea)
				{
					x1 = optionsBG.getScreenPosition().x;
					x2 = optionsBG.getScreenPosition().x + optionsBG.width;
					y1 = optionsBG.getScreenPosition().y;
					y2 = optionsBG.getScreenPosition().y + optionsBG.height;
					if (FlxG.mouse.screenX >= x1 && FlxG.mouse.screenX <= x2 && FlxG.mouse.screenY >= y1 && FlxG.mouse.screenY <= y2)
					{
						draggingMenu = true;
						menuPrevX = optionsMenu.x;
						menuPrevY = optionsMenu.y;
						cursorPrevX = FlxG.mouse.screenX;
						cursorPrevY = FlxG.mouse.screenY;
					}
				}
			}
		}

		if (FlxG.mouse.justReleased)
		{
			if (draggingMenu)
				draggingMenu = false;

			menuPrevX = 0;
			menuPrevY = 0;
			cursorPrevX = 0;
			cursorPrevY = 0;
		}

		if (FlxG.mouse.pressed)
		{
			//var offscreen:Bool = (FlxG.mouse.screenX < 0 || FlxG.mouse.screenX > FlxG.width || FlxG.mouse.screenY < 0 || FlxG.mouse.screenY > FlxG.height);
			if (draggingMenu /* && !offscreen */)
			{
				//var offsetX = FlxG.mouse.screenX - cursorPrevX;
				//var offsetY = FlxG.mouse.screenY - cursorPrevY;
				// Angel: ditched the variables since they take up more memory, especially if this runs every frame of the game
				
				optionsMenu.x = menuPrevX + (FlxG.mouse.screenX - cursorPrevX);
				optionsMenu.y = menuPrevY + (FlxG.mouse.screenY - cursorPrevY);
				AngelUtils.bounceToFrame(optionsMenu); // Angel: don't even say it Cheese, you're welcome
			}
		}
		// now back to me lol
		// Debug \\
		#if debug
		// if (FlxG.keys.justReleased.D)
		// {
		// 	remove(backdrop);
		// 	remove(background);
		// 	remove(sky);
		// 	remove(tree);
		// 	remove(selectMenu);
		// }
		// if (FlxG.keys.justReleased.A)
		// {
		// 	add(backdrop);
		// 	add(background);
		// 	add(sky);
		// 	add(tree);
		// 	add(selectMenu);
		// }
		DebugUtils.debug(nameTitle);
		DebugUtils.debug(nameSubTitle);
		if (FlxG.keys.pressed.R && FlxG.keys.pressed.CONTROL) // refresh lol
		{
			FlxG.resetGame();
		}
		#end
	}

	// Audio Pausing \\
	override public function onFocusLost()
	{
		super.onFocusLost();
		FlxG.sound.music.pause();
		trace("[SYSTEM] User Lost Focus the window");
	}

	override public function onFocus()
	{
		super.onFocus();
		FlxG.sound.music.resume();
		trace("[SYSTEM] User Focused the window");
	}

	// I just stole the fuckin' code from the github lol \\
	static function onReady()
	{
		// Updating Discord Rich Presence
		DiscordRpc.presence({
			details: 'Version: [PRIVATE BETA 2]',
			state: 'In the Main Menu.',
			largeImageKey: 'discord_rpc_512',
			largeImageText: 'Plants VS Zombies: Haxe Edition'
		});
	}

	static function onError(_code:Int, _message:String)
	{
		trace('[DISCORD RPC] Error! $_code : $_message');
	}

	static function onDisconnected(_code:Int, _message:String)
	{
		trace('[DISCORD RPC] Disconnected! $_code : $_message');
	}
}