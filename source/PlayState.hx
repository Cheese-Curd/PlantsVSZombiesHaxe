package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.ui.FlxButton;

class PlayState extends FlxState
{
	var planttype = 'peashooter';
	var plant:FlxSprite;
	var levelType = 'grass';
	var background:FlxSprite;
	var grid:FlxGridOverlay;

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

	function getPlant()
	{
		switch (planttype)
		{
			case 'sunflower':
				trace("sorry mate, I dunno how I'm going to animate this shit lmfao, I have body parts lol");
			case 'peashooter':
				trace("sorry mate, I dunno how I'm going to animate this shit lmfao, I have body parts lol");
		};
		// add(plant);
		// plant.antialiasing = true; // just so the sprites don't look bad when doing shit lol
		// plant.animation.play("idle"); // play the animation so they don't stand still
		var menubutton = new FlxButton(FlxG.width, 0, 'MainMenuState', function()
		{
			FlxG.switchState(new MainMenuState());
		});
		add(menubutton);
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
