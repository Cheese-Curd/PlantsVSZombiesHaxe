package;

import haxe.Exception;
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

	var background:Lawn;

	public static var curLevel:String = '1-1';
	public static var displayLevel:String = "1-1";

	public static var selectedPlant:String = '';

	public var zombieList:Array<Zombie> = [];
	public var plantList:Array<Plant> = [];

	public var plantGrp:FlxTypedGroup<Plant>;

	public static var houseTxt:FlxText;

	public var curRow:Int = 0;
	public var curCol:Int = 0;
	public var tileSpr:FlxSprite;
	public var plantOverlay:Plant;
	public var seedPacketList:Array<String> = ['peashooter','peashooter'];

	/*
		Lets say we have a Peashooter. Peashooter is a normal plant, in which for example, get a plantable ID of 0. 
		Plants like Pumpkin on the other hand can be placed above plant so it has an ID of 1.
		This will check if the current grid Array of that specific index is empty. 
		If it is empty, then it will allow plants to be placed.
	 */

	public var seedBank:FlxSprite;

	override public function create()
	{
		// lawnJson = AngelUtils.JsonifyFile('assets/data/levels/${curLevel}');
		// trace('playing currently ${curLevel}');

		// Load Plant Animations
		for (plant in Plant.plantIDs)
			AnimationHandler.parseAnimation('data/plants', plant);

		background = new Lawn();
		add(background);

		seedBank = new FlxSprite(100,0).loadGraphic("assets/images/ui/SeedBank.png");
		add(seedBank);

		tileSpr = new FlxSprite().makeGraphic(Std.int(background.gridWid / background.rows), Std.int(background.gridHei / background.columns), 0x7FFFFFFF);
		tileSpr.active = false;
		add(tileSpr);

		plantOverlay = new Plant(0, 0);
		plantOverlay.updateHitbox();
		plantOverlay.alpha = 0.5;
		plantOverlay.visible = false;
		plantOverlay.active = false;
		add(plantOverlay);

		for (i in 0...seedPacketList.length)
			{
				var seedPacket = new SeedPacket(0 + (i * 30),0,seedPacketList[i],100);
				seedPacket.scale.set(0.6,0.6);
				seedPacket.updateHitbox();
				add(seedPacket);
			}

		plantGrp = new FlxTypedGroup<Plant>();
		add(plantGrp);

		houseTxt = new FlxText(300, 300);
		houseTxt.color = FlxColor.WHITE;
		houseTxt.borderStyle = OUTLINE;
		houseTxt.borderSize = 2;
		houseTxt.font = 'assets/fonts/HouseofTerror-Regular.ttf';
		houseTxt.text = displayLevel;
		houseTxt.size = 40;
		houseTxt.active = false;
		// add(houseTxt);

		
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		var plantSelectedIndex:Int = Std.int(Plant.plantIDs.indexOf(selectedPlant));
		FlxG.watch.add(plantSelectedIndex, "String", "curPlantSelected");

		// Funni thingie just gets what tile the mouse is currently on
		curRow = Std.int(Math.max(0, Math.min(background.rows - 1, Math.round((FlxG.mouse.x - 30 - background.tileWid / 2) / background.tileWid))));
		curCol = Std.int(Math.max(0, Math.min(background.columns - 1, Math.round((FlxG.mouse.y - 75 - background.tileHei / 2) / background.tileHei))));

		var currentTile = background.tileData[curRow][curCol];
		var isValid = false;
		if (plantOverlay.plantableType == DEFAULT)
			isValid = !currentTile.hasDEFAULT
		else if (plantOverlay.plantableType == TILED)
			isValid = !currentTile.hasTILED
		else if (plantOverlay.plantableType == SECONDARY)
			isValid = !currentTile.hasSECONDARY;

		tileSpr.visible = plantOverlay.visible = FlxG.mouse.x >= 30
			&& FlxG.mouse.x <= background.gridWid + 30
			&& FlxG.mouse.y >= 75
			&& FlxG.mouse.y <= background.gridHei + 75
			&& isValid;

		if (tileSpr.visible)
		{
			placePlant();
		}
	}

	private function placePlant()
		{
			var currentTile = background.tileData[curRow][curCol];
			tileSpr.setPosition(curRow * background.tileWid + 30, curCol * background.tileHei + 75);
			plantOverlay.setPosition(tileSpr.x + 7.5, tileSpr.y + 12.5);

			if (FlxG.mouse.justPressed && plantOverlay.visible)
			{
				#if debug
				trace('At Row ${curRow + 1}, Coloumn: ${curCol + 1}');
				#end
				currentTile.appendPlant(plantOverlay.plantableType, () -> plantGrp.add(new Plant(plantOverlay.x, plantOverlay.y)));
			}
		}
}
