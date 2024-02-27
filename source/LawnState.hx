package;

import flixel.group.FlxGroup.FlxTypedGroup;
import openfl.geom.Point;
import flixel.util.FlxSave;
import AngelUtils; // for json reading
import discord_rpc.DiscordRpc;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.ui.FlxButton;
import DebugUtils; // Funny debug
import Plant;
import Lawn;
import SeedPacket;

typedef LevelJson =
{
	var ?flags:Int;
	var lawn:String;
	var possibleZombies:Array<String>;
}

class LawnState extends FlxState
{
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

	var lawnJson:LevelJson;

	var plant:Plant;
	var background:Lawn;

	public static var curLevel:String = '1-1';
	public static var displayLevel:String = "1-1";

	public var zombieList:Array<Zombie> = [];
	public var plantList:Array<Plant> = [];

	public var plantGrp:FlxTypedGroup<Plant>;

	public static var houseTxt:FlxText;

	public var curRow:Int = 0;
	public var curCol:Int = 0;
	public var tileSpr:FlxSprite;
	public var plantOverlay:FlxSprite;

	/*
		Lets say we have a Peashooter. Peashooter is a normal plant, in which for example, get a plantable ID of 0. 
		Plants like Pumpkin on the other hand can be placed above plant so it has an ID of 1.
		This will check if the current grid Array of that specific index is empty. 
		If it is empty, then it will allow plants to be placed.
	 */
	public var gridData:Array<Array<Array<Int>>> = [[[]]];

	override public function create()
	{
		// lawnJson = AngelUtils.JsonifyFile('assets/data/levels/${curLevel}');
		// trace('playing currently ${curLevel}');

		background = new Lawn(-220, 0, "grass", 9, 5);
		add(background);

		for (i in 0...background.rowsNumber)
			gridData[i] = [for (j in 0...background.colsNumber) []];

		tileSpr = new FlxSprite().makeGraphic(Std.int(background.gridWid / background.rowsNumber), Std.int(background.gridHei / background.colsNumber),
			0x7FFFFFFF);
		add(tileSpr);

		plantOverlay = new Plant(0, 0);
		plantOverlay.updateHitbox();
		plantOverlay.alpha = 0.5;
		plantOverlay.visible = false;
		plantOverlay.active = false;
		add(plantOverlay);

		plantGrp = new FlxTypedGroup<Plant>();
		add(plantGrp);

		houseTxt = new FlxText(300, 300);
		houseTxt.color = FlxColor.WHITE;
		houseTxt.borderStyle = OUTLINE;
		houseTxt.borderSize = 2;
		houseTxt.font = 'assets/fonts/HouseofTerror-Regular.ttf';
		houseTxt.text = displayLevel;
		houseTxt.size = 40;
		add(houseTxt);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		// Funni thingie just gets what tile the mouse is currently on
		curRow = Std.int(Math.max(0, Math.min(background.rowsNumber - 1, Math.round((FlxG.mouse.x - 30 - background.tileWid / 2) / background.tileWid))));
		curCol = Std.int(Math.max(0, Math.min(background.colsNumber - 1, Math.round((FlxG.mouse.y - 75 - background.tileHei / 2) / background.tileHei))));

		tileSpr.visible = plantOverlay.visible = FlxG.mouse.x >= 30
			&& FlxG.mouse.x <= background.gridWid + 30
			&& FlxG.mouse.y >= 75
			&& FlxG.mouse.y <= background.gridHei + 75
			&& !gridData[curRow][curCol].contains(0);

		if (tileSpr.visible)
		{
			tileSpr.setPosition(curRow * background.tileWid + 30, curCol * background.tileHei + 75);
			plantOverlay.setPosition(tileSpr.x + 7.5, tileSpr.y + 12.5);

			if (FlxG.mouse.justPressed && plantOverlay.visible)
			{
				#if debug
				trace('Planted at [Row: $curRow\tColoumn: $curCol]');
				#end

				var plant = new Plant(plantOverlay.x, plantOverlay.y);
				plantGrp.add(plant);
				gridData[curRow][curCol].push(0);
			}
		}
	}
}
