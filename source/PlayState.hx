package;

import flixel.util.FlxSave;
import AngelUtils; // for json reading
import discord_rpc.DiscordRpc;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.ui.FlxButton;
import DebugUtils; // Funny debug
import Plant;
import Lawn;
import SeedPacket;

class PlayState extends FlxState
{
	// var planttype = DataShit.plantType[0];
	var zombie:Zombie;
	var levelType = 'grass';
	var background:Lawn;
	var backgroundGrass:FlxSprite; // reference for size and stuff
	var seedPack:SeedPacket;
	var grid:FlxSprite; // for plant placement
	var _gamedata:FlxSave;
	var menuButton:FlxButton;

	// ==========Pause shit========== \\
	var lostfocuspause:FlxSprite;

	override public function onFocus()
	{
		super.onFocus();
		FlxG.sound.music.resume();
		trace("[SYSTEM] User Focused the window");
	}

	override public function onFocusLost()
	{
		super.onFocusLost();
		FlxG.sound.music.pause();
		trace("[SYSTEM] User Lost Focus the window");
	}

	// Character shit \\
	function framesArray(num:Int)
	{
		var array:Array<Int> = new Array<Int>();
		for (i in 0...num)
			array.push(i);
		return array;
	}

	override public function create()
	{
		super.create();

		background = new Lawn(-220, 0, "grass", 5, 9);
		backgroundGrass = new FlxSprite(-220, 0);
		lostfocuspause = new FlxSprite();

		getLevel();
		add(background);
		add(backgroundGrass);

		grid = FlxGridOverlay.create(1, 1, background.rows, background.columns);
		grid.antialiasing = false;
		grid.scale.set(90, 90);
		grid.updateHitbox();
		grid.x += 100;
		add(grid);

		zombie = new Zombie(200, 100, "basic", true);
		add(zombie);

		seedPack = new SeedPacket(0, 0, "peashooter", 100);
		seedPack.screenCenter();
		seedPack.x += 150;
		add(seedPack);

		menuButton = new FlxButton(681, -12, '', pauseBitch);
		menuButton.loadGraphic('assets/images/menu/inGamePause.png', true, 117, 48);
		add(menuButton);

		// game data \\
		_gamedata = new FlxSave();
		_gamedata.bind("Save");
		// Level shit \\
		if (_gamedata.data.world == 1)
		{
			levelType = 'grass';
			if (_gamedata.data.level == 1 || _gamedata.data.level == 2 || _gamedata.data.level == 3)
			{
				levelType = 'grass_dirt';
			}
		}
		else if (_gamedata.data.world == 2)
		{
			levelType = 'night';
		}
		else if (_gamedata.data.world == 3)
		{
			levelType = 'pool';
		}
		else if (_gamedata.data.world == 4)
		{
			levelType = 'pool_night';
		}
		else if (_gamedata.data.world == 5)
		{
			levelType = 'roof';
		}
		else if (_gamedata.data.world == 6)
		{
			levelType = 'roof_night';
		}
	}

	function pauseBitch() {}

	function getLevel()
	{
		trace('level Type is ' + levelType);
		switch (levelType)
		{
			case 'grass_dirt':
				DiscordRpc.presence({
					details: 'Version: [PRIVATE BETA 2]',
					state: 'Waiting for User Input...',
					largeImageKey: 'discord_rpc_512',
					largeImageText: 'Plants VS Zombies: Haxe Edition'
				});
				background.reloadImage('assets/images/levels/grassday/grassday_dirt.png');
				FlxG.sound.playMusic('assets/music/grasswalk.ogg');
			case 'grass':
				DiscordRpc.presence({
					details: 'Version: [PRIVATE BETA 2]',
					state: 'Waiting for User Input...',
					largeImageKey: 'discord_rpc_512',
					largeImageText: 'Plants VS Zombies: Haxe Edition'
				});
				background.reloadImage('assets/images/levels/grassday/grassday.png');
				FlxG.sound.playMusic('assets/music/grasswalk.ogg');
			case 'night':
				DiscordRpc.presence({
					details: 'Version: [PRIVATE BETA 2]',
					state: 'Waiting for User Input...',
					largeImageKey: 'discord_rpc_512',
					largeImageText: 'Plants VS Zombies: Haxe Edition'
				});
				background.reloadImage('assets/images/levels/grassnight/grassnight.jpg');
				FlxG.sound.playMusic('assets/music/moongrains.ogg');
			case 'pool':
				DiscordRpc.presence({
					details: 'Version: [PRIVATE BETA 2]',
					state: 'Waiting for User Input...',
					largeImageKey: 'discord_rpc_512',
					largeImageText: 'Plants VS Zombies: Haxe Edition'
				});
				background.reloadImage('assets/images/levels/poolday/poolday.jpg');
				if (_gamedata.data.fastpool == true)
				{
					FlxG.sound.playMusic('assets/music/watery_graves_fast.ogg'); // faster
				}
				else
				{
					FlxG.sound.playMusic('assets/music/watery_graves.ogg'); // default/slower
				}
			case 'night_pool':
				DiscordRpc.presence({
					details: 'Version: [PRIVATE BETA 2]',
					state: 'Waiting for User Input...',
					largeImageKey: 'discord_rpc_512',
					largeImageText: 'Plants VS Zombies: Haxe Edition'
				});
				background.reloadImage('assets/images/levels/poolnight/poolnight.jpg');
				FlxG.sound.playMusic('assets/music/rigor_moris.ogg'); // play fog music and stuff
			case 'roof':
				DiscordRpc.presence({
					details: 'Version: [PRIVATE BETA 2]',
					state: 'Playing Adventure',
					smallImageKey: 'discord_rpc_512_adventure',
					smallImageText: 'Playing: ' + _gamedata.data.world + '-' + _gamedata.data.level,
					largeImageKey: 'discord_rpc_512',
					largeImageText: 'Plants VS Zombies: Haxe Edition'
				});
				background.reloadImage('assets/images/levels/roofday/roofday.jpg');
				FlxG.sound.playMusic('assets/music/graze_the_roof.ogg');
			case 'roof_night':
				DiscordRpc.presence({
					details: 'Version: [PRIVATE BETA 2]',
					state: 'Playing the final Adventure Level!',
					largeImageKey: 'discord_rpc_512',
					smallImageKey: 'discord_rpc_512_boss',
					smallImageText: 'holy shit they are about to beat the game, partly',
					largeImageText: 'Plants VS Zombies: Haxe Edition'
				});
				background.reloadImage('assets/images/levels/roofnight/roofnight.jpg');
				FlxG.sound.playMusic('assets/music/brainiac_maniac.ogg');
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.PERIOD)
		{
			_gamedata.data.world++;
			if (_gamedata.data.world > 6)
			{
				_gamedata.data.world = 1;
			};
			getLevel();
		}
		if (FlxG.keys.justPressed.COMMA)
		{
			_gamedata.data.level++;
			if (_gamedata.data.level > 3)
			{
				_gamedata.data.level = 1;
			};
			getLevel();
		}
		DebugUtils.debug(menuButton);
		if (FlxG.keys.justReleased.G)
		{
			if (levelType == 'grass_dirt')
			{
				levelType = 'grass';
				getLevel();
			}
			else
			{
				levelType = 'grass_dirt';
				getLevel();
			}
		}
	}
}
