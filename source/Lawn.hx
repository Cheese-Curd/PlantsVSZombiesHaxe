package;

import Plant.PlantableType;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import haxe.Json;
import openfl.utils.Assets;

// enum LawnTimes {
// 	DAY;
// 	NIGHT;
// }

typedef LawnData =
{
	var spriteOffsetX:Int;
	var spriteOffsetY:Int;
	var cols:Int;
	var rows:Int;
	//var time:LawnTimes;
}

class Lawn extends FlxSpriteGroup
{
	public var lawnJson:LawnData;

	public var columns:Int;
	public var rows:Int;
	public var type:String;
	// public var tileZone:Tile;
	public var lawnSprite:FlxSprite;

	public var gridWid:Int = 720;
	public var gridHei:Int = 500;
	public var tileWid:Float = 80;
	public var tileHei:Float = 100;
	public var tileData:Array<Array<Tile>> = [];

	public function new(x:Float = 0, y:Float = 0, backgroundType:String = "grassday", ?row:Int = 9, ?column:Int = 5)
	{
		super(x, y);

		lawnJson = Json.parse(Assets.getText('assets/data/lawns/${backgroundType}.json'));
		

		this.rows = lawnJson.rows;
		this.columns = lawnJson.cols;
		this.type = backgroundType;

		tileData = [for (i in 0...rows) [for (j in 0...column) new Tile()]];
		lawnSprite = new FlxSprite();
		lawnSprite.loadGraphic('assets/images/levels/${backgroundType}/${backgroundType}.png');
		lawnSprite.active = false;
		lawnSprite.offset.x = lawnJson.spriteOffsetX;
		lawnSprite.offset.y = lawnJson.spriteOffsetY;
		add(lawnSprite);
	}

	public function reloadImage(imagePath:String)
	{
		lawnSprite.loadGraphic(imagePath);
	}
}

class Tile
{
	public var tileType:TileType;
	public var specialType:SpecialType;
	public var hasTILED:Bool; // for Plants like Lilypad &  Flower Pot.
	public var hasDEFAULT:Bool; // for Plants like Peashooter ect.
	public var hasSECONDARY:Bool; // for Plants like Pumpkin ect.
	public var storedPlants:Array<Plant>;

	public function new(tileType:TileType = NORMAL, specialType:SpecialType = DAY)
	{
		this.tileType = tileType;
		this.specialType = specialType;
		this.hasTILED = false;
		this.hasDEFAULT = false;
		this.hasSECONDARY = false;
		this.storedPlants = [];
	}

	public function appendPlant(type:PlantableType, callback:Void->Plant)
	{
		var isValid = false;
		if (type == DEFAULT)
			isValid = !hasDEFAULT;
		else if (type == TILED)
			isValid = !hasTILED;
		else if (type == SECONDARY)
			isValid = !hasSECONDARY;

		if (!isValid)
			return;

		if (type == DEFAULT)
			hasDEFAULT = true;
		else if (type == TILED)
			hasTILED = false;
		else if (type == SECONDARY)
			hasSECONDARY = false;

		var plant = callback();
		storedPlants.push(plant);
		updatePlants();

		#if debug
		trace('planted \'${Plant.plantIDs[plant.plantID]}\'');
		#end
	}

	public function updatePlants() {}
}

enum TileType
{
	INVALID;
	NORMAL;
	DESTROYED;
	WATER;
	ROOF;
}

enum SpecialType
{
	DAY;
	NIGHT;
	ALL;
}
