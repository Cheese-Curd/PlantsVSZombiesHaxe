package;

import Plant.PlantableType;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import haxe.Json;

// import utils.TilePvZ as Tile;

typedef LawnData =
{
	var cols:Int;
	var rows:Int;
	var type:String;
}

class Lawn extends FlxSpriteGroup
{
	public var jsonSystem:LawnData;

	public var columns:Int;
	public var rows:Int;
	// public var tileZone:Tile;
	public var lawnSprite:FlxSprite;

	public var gridWid:Int = 720;
	public var gridHei:Int = 500;
	public var tileWid:Float = 80;
	public var tileHei:Float = 100;
	public var tileData:Array<Array<Tile>> = [];

	public function new(x:Float = 0, y:Float = 0, backgroundType:String = "grass", rows:Int = 9, column:Int = 5)
	{
		super(x, y);

		this.rows = rows;
		this.columns = column;

		tileData = [for (i in 0...rows) [for (j in 0...column) new Tile()]];
		lawnSprite = new FlxSprite();
		lawnSprite.loadGraphic('assets/images/levels/grassday/grassday.png');
		lawnSprite.active = false;
		lawnSprite.offset.x = 220;
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
