import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import openfl.geom.Point;
import flixel.animation.FlxAnimationController;
import openfl.utils.Assets;
import haxe.Json;

/**
 * Author: Inliothixi (2024)
 */
class AnimationHandler
{
	static public var animations:Map<String, Animation> = new Map<String, Animation>();

	/**
	 * Get existing animation to avoid duplicated and save memory.
	 * @param path Path to Json Data containing Animation ( e.g. `assets/data/plants/peashooter.json`)
	 * @param key Key for Animation to avoid duplicates (e.g. `peashooter`)
	 */
	static public function parseAnimation(path:String, key:String):Void
	{
		if (animations.exists(key))
			return;

		var datas:PlantJson = Json.parse(Assets.getText(Paths.json(key, '$path/$key')));
		animations[key] = new Animation(Paths.getSparrowAtlas('plants/${datas.textureName}'));
		for (anim in datas.anims)
		{
			animations[key].sprite.animation.addByPrefix(anim.prefix, anim.postfix, anim.fps, anim.looped);
			animations[key].offsets[anim.prefix] = new Point(anim.x, anim.y);
		}
	}
}

class Animation
{
	public var offsets:Map<String, Point>;
	public var sprite:FlxSprite;

	public function new(frames:FlxAtlasFrames)
	{
		this.offsets = new Map<String, Point>();
		this.sprite = new FlxSprite();
		this.sprite.frames = frames;
		this.sprite.animation = new FlxAnimationController(sprite);
		this.sprite.kill();
		this.sprite.active = false;
	}
}

typedef PlantJson =
{
	var textureName:String;
	var health:Float;
	var price:Float;
	var isSpecial:Bool;
	var anims:Array<AnimationData>;
	var flipX:Bool;
	var flipY:Bool;
}

typedef AnimationData =
{
	var x:Float;
	var y:Float;
	var prefix:String;
	var postfix:String;
	var fps:Int;
	var looped:Bool;
}
