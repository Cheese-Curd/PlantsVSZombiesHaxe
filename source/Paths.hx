package;

import openfl.Assets;
import flixel.FlxG;
#if sys
import sys.FileSystem;
#end
import flixel.graphics.frames.FlxAtlasFrames;

class Paths
{
	public static function file(key:String, location:String, extension:String):String
	{
		var data:String = 'assets/$location/$key.$extension';
		return data;
	}

	public static function image(key:String/* , forceLoadFromDisk:Bool = false */):Dynamic
	{
		return file(key, 'images', 'png');
	}

	public static function xml(key:String, ?location:String = "images")
	{
		return file(key, location, "xml");
	}

	public static function text(key:String, ?location:String = "data")
	{
		return file(key, location, "txt");
	}

	public static function json(key:String, ?location:String = "data")
	{
		return file(key, location, "json");
	}

	public static function sound(key:String)
	{
		return file(key, "sounds", 'ogg');
	}

	public static function music(key:String)
	{
		return file(key, "music", 'ogg');
	}

	public static function getSparrowAtlas(key:String)
	{
		return FlxAtlasFrames.fromSparrow(image(key), xml(key));
	}

	public static function getPackerAtlas(key:String)
	{
		return FlxAtlasFrames.fromSpriteSheetPacker(image(key), text(key, "images"));
	}

	public static function video(key:String)
	{
		return file(key, "videos", "mp4");
	}

	public static function font(key:String, ?extension:String = "ttf")
	{
		return file(key, "fonts", extension);
	}
}