package;

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

	public static var houseTxt:FlxText;

	public var curTile:Point = new Point();
	public var tileSpr:FlxSprite;

	override public function create()
	{
		// lawnJson = AngelUtils.JsonifyFile('assets/data/levels/${curLevel}');
		// trace('playing currently ${curLevel}');

		background = new Lawn(-220, 0, "grass", 9, 5);
		add(background);

		tileSpr = new FlxSprite().makeGraphic(Std.int(background.gridWid / background.rowsNumber), Std.int(background.gridHei / background.colsNumber),
			0x7FFFFFFF);
		add(tileSpr);

		plant = new Plant(30, 75, "peashooter", false);
		add(plant);

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
		curTile.x = Math.max(0, Math.min(background.rowsNumber - 1, Math.round((FlxG.mouse.x - 30 - background.tileWid / 2) / background.tileWid)));
		curTile.y = Math.max(0, Math.min(background.colsNumber - 1, Math.round((FlxG.mouse.y - 75 - background.tileHei / 2) / background.tileHei)));

		// 20, 75 is the first tile position from 0, 0
		tileSpr.setPosition(curTile.x * background.tileWid + 30, curTile.y * background.tileHei + 75);

		if (FlxG.mouse.justPressed)
		{
			var plant = new Plant(tileSpr.x, tileSpr.y);
			add(plant);
		}
	}
}
