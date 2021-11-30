package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxSpriteUtil;
import haxe.Json;
import openfl.utils.Assets as OpenFlAssets;

class AngelUtils
{
	public static function fromAlphaMask(sprPath:String, maskPath:String, X:Float = 0, Y:Float = 0)
	{
		return FlxSpriteUtil.alphaMaskFlxSprite(new FlxSprite().loadGraphic(sprPath), new FlxSprite().loadGraphic(maskPath), new FlxSprite(X, Y));
	}

	public static function JsonifyFile(path:String)
	{
		return Json.parse(OpenFlAssets.getText(path));
	}

	// Angel: cheese wrote none of this lmfao
	public static function bounceToFrame(object:FlxObject, ?frame:ObjectFrame):FlxPoint
	{
		if (frame == null) frame = { "x":0, "y":0, "width":FlxG.width, "height":FlxG.height };
		if (object.x < frame.x) object.x = frame.x;
		else if (object.x + object.width > frame.x + frame.width) object.x = frame.x + frame.width - object.width;
		if (object.y < frame.y) object.y = frame.y;
		else if (object.y + object.height > frame.y + frame.height) object.y = frame.y + frame.height - object.height;
		return object.getPosition();
	}
}

typedef ObjectFrame =
{
	x:Float,
	y:Float,
	width:Float,
	height:Float
}