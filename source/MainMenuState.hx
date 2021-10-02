package;

import AngelUtils; // for masking and reading json lol
import DataShit; // getting data
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import lime.app.Application;

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
	var optionsMenu:FlxSprite;
	var optionsOpen = false;

	// Select Menu Buttons \\
	/* ==Menu Button Pathss==
		Adventure Start: 'assets/images/menu/mainmenu/SelectorScreen_StartAdventure_Button1.png'
		Adventure Start Shadow: 'assets/images/menu/mainmenu/SelectorScreen_Shadow_StartAdventure.png'
		Adventure: 'assets/images/menu/mainmenu/SelectorScreen_Adventure_Button.png'
		Adventure Shadow: 'assets/images/menu/mainmenu/SelectorScreen_Shadow_Adventure.png'
	 */
	var gamedata:GameData;
	var adventure:FlxButton;
	var adventure_shadow:FlxSprite;
	var minigame:FlxButton;
	var minigame_shadow:FlxSprite;
	// Pot Buttons \\
	var options:FlxButton;
	var help:FlxButton;
	var quit:FlxButton;

	override public function create()
	{
		// game data \\
		gamedata = AngelUtils.JsonifyFile('assets/data/gamedata.json');
		// everything else \\
		background = new FlxSprite();
		background.makeGraphic(800, 600, FlxColor.WHITE);
		super.create();
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
			'assets/images/menu/mainmenu/SelectorScreen_BG_Center_.png', 40, 250);
		add(sky);
		add(backdrop);
		sky.setGraphicSize(800, 600);
		sky.updateHitbox();
		add(tree);
		add(selectMenu); // thank you Angel for helping me to get the masks to work, and for the Utils <3
		backdrop.setGraphicSize(800, 350);
		// selectMenu.y = 40;
		// selectMenu.x = 70;

		// Get the Select Menu Buttons \\
		getButtons();
		trace('tried loading buttons');
	}

	function getButtons()
	{
		trace('loaded button function');
		// Adventure Button \\
		adventure = new FlxButton(405, 65, "", openAdventure);
		if (gamedata.newgame == true)
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
		trace('adventure button');
		// Mini-Games Button \\
		minigame = new FlxButton(405, 65, "", openMinigames);
		minigame.loadGraphic('assets/images/menu/mainmenu/SelectorScreen_Survival_button.png', true, 313, 133);
		minigame_shadow = new FlxSprite().loadGraphic('assets/images/menu/mainmenu/SelectorScreen_Shadow_Survival.png');
		minigame.y = 173;
		minigame.x = 406;
		minigame_shadow.x = 407;
		minigame_shadow.y = 177;
		if (gamedata.minigames == false)
		{
			minigame.color = 0xFF808080;
		}
		trace('Mini-Games button');

		add(adventure_shadow);
		add(minigame_shadow);
		add(adventure);
		add(minigame);

		// Pot Buttons \\
		trace('started Pot Button collection...');
		options = new FlxButton(565, 490, "", optionsShit);
		options.loadGraphic('assets/images/menu/mainmenu/SelectorScreen_Options.png', true, 81, 31);
		help = new FlxButton(647, 529, "", helpShit);
		help.loadGraphic('assets/images/menu/mainmenu/SelectorScreen_Help.png', true, 46, 22);
		quit = new FlxButton(720, 515, "", quitShit);
		quit.loadGraphic('assets/images/menu/mainmenu/SelectorScreen_Quit.png', true, 45, 27);
		add(options);
		add(help);
		add(quit);
		trace('finished get buttons function');
	}

	function openAdventure()
	{
		if (gamedata.newgame == true)
		{
			trace("New Adventure");
		}
		else
		{
			trace("Resume Adventure");
		}
	}

	function openMinigames()
	{
		if (gamedata.minigames == true)
		{
			trace("MiniGame Unlocked");
		}
		else
		{
			trace("MiniGame Locked");
		}
	}

	function optionsShit()
	{
		optionsMenu = AngelUtils.fromAlphaMask('assets/images/menu/options_menuback.jpg', 'assets/images/menu/options_menuback_.png', 0, 0);
		trace('Is the options Menu Open? ' + if (optionsOpen == false)
		{
			'No.';
		} else
		{
			'Yes.';
		});
		if (optionsOpen == true)
		{
			remove(optionsMenu);
			optionsOpen = false;
		}
		else
		{
			add(optionsMenu);
			optionsOpen = true;
		}
	}

	function helpShit()
	{
		trace("help lol");
	}

	function quitShit()
	{
		lime.system.System.exit(0);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		// keep it running when it's a live and kill it when it's not?????? \\
		DiscordRpc.process();
		if (false)
		{
			DiscordRpc.shutdown();
		}
		// Debug \\
		if (FlxG.keys.justReleased.ENTER)
		{
			trace(' Y: ' + help.y);
			trace(' X: ' + help.x);
		}
		if (FlxG.keys.justReleased.ESCAPE) {}
		if (FlxG.keys.justReleased.D)
		{
			remove(tree);
			remove(selectMenu);
		}
		if (FlxG.keys.justReleased.A)
		{
			add(tree);
			add(selectMenu);
		}
		// y \\
		if (FlxG.keys.justReleased.UP)
		{
			help.y--;
		}
		if (FlxG.keys.justReleased.DOWN)
		{
			help.y++;
		}
		// x \\
		if (FlxG.keys.justReleased.RIGHT)
		{
			help.x++;
		}
		if (FlxG.keys.justReleased.LEFT)
		{
			help.x--;
		}
		if (FlxG.keys.justReleased.R)
		{
			FlxG.switchState(new LoadingState());
		}
	}

	// Audio Pausing \\
	override public function onFocusLost()
	{
		super.onFocusLost();
		FlxG.sound.music.pause();
		trace("User Lost Focus the window");
	}

	override public function onFocus()
	{
		super.onFocus();
		FlxG.sound.music.resume();
		trace("User Focused the window");
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
		trace('Error! $_code : $_message');
	}

	static function onDisconnected(_code:Int, _message:String)
	{
		trace('Disconnected! $_code : $_message');
	}
}
