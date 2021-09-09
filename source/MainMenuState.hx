package;

import AngelUtils; // for masking and reading json lol
import DataShit; // getting data
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
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
			details: 'Version: [PRIVATE BETA 1]',
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
		if (gamedata.newgame == true)
		{
			adventure = new FlxButton(405, 65, "", openAdventure);
			adventure.loadGraphic('assets/images/menu/mainmenu/SelectorScreen_StartAdventure_Button1.png', true, 331, 146);
			adventure_shadow = new FlxSprite().loadGraphic('assets/images/menu/mainmenu/SelectorScreen_Shadow_StartAdventure.png');
			adventure_shadow.x = 399;
			adventure_shadow.y = 66;
			trace('adventure button');
		}
		else
		{
			adventure = new FlxButton(405, 65, "", openAdventure);
			adventure.loadGraphic('assets/images/menu/mainmenu/SelectorScreen_Adventure_button.png', true, 331, 146);
			adventure_shadow = new FlxSprite().loadGraphic('assets/images/menu/mainmenu/SelectorScreen_Shadow_Adventure.png');
			adventure_shadow.x = 399;
			adventure_shadow.y = 65;
			trace('adventure button');
		}
		// Mini-Games Button \\
		if (gamedata.minigames == true)
		{
			minigame = new FlxButton(405, 65, "", openMinigames);
			adventure.loadGraphic('assets/images/menu/mainmenu/SelectorScreen_Survival_button.png', true, 331, 146);
			minigame_shadow = new FlxSprite().loadGraphic('assets/images/menu/mainmenu/SelectorScreen_Shadow_Survival.png');
			minigame_shadow.x = 399;
			minigame_shadow.y = 66;
			trace('Mini-Games button');
		}
		else
		{
			minigame = new FlxButton(405, 65, "", openMinigames);
			minigame.loadGraphic('assets/images/menu/mainmenu/SelectorScreen_Survival_button.png', true, 331, 146);
			minigame_shadow = new FlxSprite().loadGraphic('assets/images/menu/mainmenu/SelectorScreen_Shadow_Survival.png');
			minigame_shadow.x = 399;
			minigame_shadow.y = 65;
			// minigame.color = 0xFF808080;
			trace('Mini-Games button');
		}

		add(adventure_shadow);
		add(adventure);
		add(minigame_shadow);
		add(minigame);
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
			trace('Y: ' + minigame.y);
			trace('Y: ' + minigame.x);
			trace('Shadow Y: ' + minigame_shadow.y);
			trace('Shadow X: ' + minigame_shadow.x);
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
			minigame.y--;
			adventure_shadow.y--;
		}
		if (FlxG.keys.justReleased.DOWN)
		{
			minigame.y++;
			minigame_shadow.y++;
		}
		// x \\
		if (FlxG.keys.justReleased.RIGHT)
		{
			minigame.x++;
			minigame_shadow.x++;
		}
		if (FlxG.keys.justReleased.LEFT)
		{
			minigame.x--;
			minigame_shadow.x--;
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
			details: 'Version: [PRIVATE BETA 1]',
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
