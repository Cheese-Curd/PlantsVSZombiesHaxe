package;

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

	public var colsNumber:Int;
	public var rowsNumber:Int;
	// public var tileZone:Tile;
	public var lawnSprite:FlxSprite;

	public var gridWid:Int = 720;
	public var gridHei:Int = 500;
	public var tileWid:Float = 80;
	public var tileHei:Float = 100;
	public var tileData:Array<Array<Tile>>;

	public function new(x:Float = -220, y:Float = 0, backgroundType:String = "grass", rowsNum:Int = 5, colsNum:Int = 9)
	{
		super(x, y);

		colsNumber = colsNum;
		rowsNumber = rowsNum;

		// tileZone = new Tile(x,y,rowsNumber,colsNumber);
		lawnSprite = new FlxSprite();
		lawnSprite.loadGraphic('assets/images/levels/grassday/grassday.png');
		add(lawnSprite);
		// add(tileZone);
	}

	public function reloadImage(imagePath:String)
	{
		lawnSprite.loadGraphic(imagePath);
	}
}

class Tile
{
	var tileType:TileType;
	var hasTilePlant:Bool; // for Plants like Lilypad &  Flower Pot.
	var hasPrimaryPlant:Bool; // for Plants like Peashooter ect.
	var hasSecondaryPlant:Bool; // for Plants like Pumpkin ect.
	var storedPlants:Array<Plant>;

	public function new(tileType:TileType = NORMAL)
	{
		this.tileType = tileType;
		this.hasPrimaryPlant = false;
		this.hasSecondaryPlant = false;
		this.hasSecondaryPlant = false;
		this.storedPlants = [];
	}

	public function appendPlant(plant:Plant) {}
}

enum TileType
{
	INVALID;
	NORMAL;
	DESTROYED;
	WATER;
	ROOF;
}
