package;

import AngelUtils; // for json reading
import DataShit; // getting data
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.ui.FlxButton;

class PlayState extends FlxState
{
	var planttype = 'peashooter';
	var plant:FlxSprite;
	var zombietype = 'basic';
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
		if (gamedata.world == "1")
		{
			if (gamedata.level == "1" || gamedata.level == "2" || gamedata.level == "3")
			{
				levelType = 'grass_dirt';
			}
			levelType = 'grass';
		}
		else if (gamedata.world == "2")
		{
			levelType = 'night';
		}
		else if (gamedata.world == "3")
		{
			levelType = 'pool';
		}
	}

	function getLevel()
	{
		trace('level Type is ' + levelType);
		switch (levelType)
		{
			case 'grass_dirt':
				background.loadGraphic('assets/images/levels/grassday_dirt.jpg');
				FlxG.sound.playMusic('assets/music/grasswalk.ogg');
				background.x = -219;
			case 'grass':
				background.loadGraphic('assets/images/levels/grassday.jpg');
				FlxG.sound.playMusic('assets/music/grasswalk.ogg');
			case 'night':
				trace('unfinished');
			case 'pool':
				trace('unfinished');
			case 'night_grass':
				trace('unfinished');
			case 'night_pool':
				trace('unfinished');
			case 'roof':
				trace('unfinished');
			case 'roof_night':
				trace('unfinished');
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

		// Background Debug \\
		if (FlxG.keys.justReleased.ENTER)
		{
			trace('Y: ' + background.y);
			trace('X: ' + background.x);
		}
		// y \\
		if (FlxG.keys.justReleased.UP)
		{
			background.y++;
		}
		if (FlxG.keys.justReleased.DOWN)
		{
			background.y--;
		}
		// x \\
		if (FlxG.keys.justReleased.RIGHT)
		{
			background.x++;
		}
		if (FlxG.keys.justReleased.LEFT)
		{
			background.x--;
		}
		// scale \\
		if (FlxG.keys.justReleased.MINUS)
		{
			background.scale.set(background.scale.x - 0.1);
		}
		if (FlxG.keys.justReleased.PLUS)
		{
			background.scale.set(background.scale.x + 0.1);
		}
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
