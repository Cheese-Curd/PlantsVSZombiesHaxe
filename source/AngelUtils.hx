package;

import flixel.addons.display.FlxExtendedSprite;
import flixel.FlxSprite;
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
}
