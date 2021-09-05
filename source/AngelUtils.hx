package;

import flixel.FlxSprite;
import flixel.util.FlxSpriteUtil;

class AngelUtils
{
	public static function fromAlphaMask(sprPath:String, maskPath:String, X:Float = 0, Y:Float = 0)
	{
		return FlxSpriteUtil.alphaMaskFlxSprite(new FlxSprite().loadGraphic(sprPath), new FlxSprite().loadGraphic(maskPath), new FlxSprite(X, Y));
	}
}
