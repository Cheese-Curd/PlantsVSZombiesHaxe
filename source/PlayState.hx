package;

import AngelUtils; // for json reading
import DataShit; // getting data
import discord_rpc.DiscordRpc;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.ui.FlxButton;
import DebugUtils; // Funny debug

class PlayState extends FlxState
{
	var planttype = DataShit.plantType[0];
	var plant:FlxSprite;
	var zombietype = DataShit.zombieType[0];
	var zombie:Zombie;
	var levelType = 'grass';
	var background:FlxSprite;
	var grid:FlxGridOverlay;
	var gamedata:GameData;

	// ==========Pause shit========== \\
	var lostfocuspause:FlxSprite;

	override public function onFocus()
	{
		return;
	}

	override public function onFocusLost()
	{
		return;
		// add(lostfocuspause);
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

		plant = new FlxSprite();
		background = new FlxSprite();
		lostfocuspause = new FlxSprite();
		getLevel();
		add(background);
		var menubutton = new FlxButton(FlxG.width, 0, 'MainMenuState', function()
		{
			FlxG.switchState(new MainMenuState()); // error I'm talking about in DataShit.hx
		});
		add(menubutton);

		// game data \\
		gamedata = AngelUtils.JsonifyFile('assets/data/gamedata.json');
		// Level shit \\
		if (gamedata.world == 1)
		{
			if (gamedata.level == 1 || gamedata.level == 2 || gamedata.level == 3)
			{
				levelType = 'grass_dirt';
			}
			levelType = 'grass';
		}
		else if (gamedata.world == 2)
		{
			levelType = 'night';
		}
		else if (gamedata.world == 3)
		{
			levelType = 'pool';
		}
		else if (gamedata.world == 4)
		{
			levelType = 'pool_night';
		}
		else if (gamedata.world == 5)
		{
			levelType = 'roof';
		}
		else if (gamedata.world == 6)
		{
			levelType = 'roof_night';
		}
	}

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
				background.loadGraphic('assets/images/levels/grassday_dirt.jpg');
				FlxG.sound.playMusic('assets/music/grasswalk.ogg');
				background.x = -219;
			case 'grass':
				DiscordRpc.presence({
					details: 'Version: [PRIVATE BETA 2]',
					state: 'Waiting for User Input...',
					largeImageKey: 'discord_rpc_512',
					largeImageText: 'Plants VS Zombies: Haxe Edition'
				});
				background.loadGraphic('assets/images/levels/grassday.jpg');
				FlxG.sound.playMusic('assets/music/grasswalk.ogg');
			case 'night':
				DiscordRpc.presence({
					details: 'Version: [PRIVATE BETA 2]',
					state: 'Waiting for User Input...',
					largeImageKey: 'discord_rpc_512',
					largeImageText: 'Plants VS Zombies: Haxe Edition'
				});
				background.loadGraphic('assets/images/levels/grassnight.jpg');
				FlxG.sound.playMusic('assets/music/moongrains.ogg');
			case 'pool':
				DiscordRpc.presence({
					details: 'Version: [PRIVATE BETA 2]',
					state: 'Waiting for User Input...',
					largeImageKey: 'discord_rpc_512',
					largeImageText: 'Plants VS Zombies: Haxe Edition'
				});
				background.loadGraphic('assets/images/levels/poolday.jpg');
				if (gamedata.fastpool == true)
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
				background.loadGraphic('assets/images/levels/poolnight.jpg');
				FlxG.sound.playMusic('assets/music/rigor_moris.ogg'); // play fog music and stuff
			case 'roof':
				DiscordRpc.presence({
					details: 'Version: [PRIVATE BETA 2]',
					state: 'Playing Adventure',
					smallImageKey: 'discord_rpc_512_adventure',
					smallImageText: 'Playing: ' + gamedata.world + '-' + gamedata.level,
					largeImageKey: 'discord_rpc_512',
					largeImageText: 'Plants VS Zombies: Haxe Edition'
				});
				background.loadGraphic('assets/images/levels/roofday.jpg');
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
				background.loadGraphic('assets/images/levels/roofnight.jpg');
				FlxG.sound.playMusic('assets/music/brainiac_maniac.ogg');
		}
	}

	function getZombie()
	{
		switch (zombietype)
		{
			case 'basic':
			// zombie = AngelUtils.JsonifyFile('assets/data/zombies/basic.json');
			case 'cone':

			case 'bucket':

			case 'screendoor':
		};
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.PERIOD)
		{
			gamedata.world++;
			if (gamedata.world > 6)
			{
				gamedata.world = 1;
			};
		}
		if (FlxG.keys.justPressed.COMMA)
		{
			gamedata.level++;
			if (gamedata.level > 3)
			{
				gamedata.level = 1;
			};
		}
		//DebugUtils.debug(background);
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
