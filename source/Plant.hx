package;

import flixel.FlxSprite;
import haxe.Json;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import openfl.Assets;

typedef AnimLoader =
{
	var prefix:String;
	var postfix:String;
	var x:Float;
	var y:Float;
	var fps:Int;
	var looped:Bool;
}

typedef PlantJson= 
{
    var textureName:String;
    var health:Float;
    var isSpecial:Bool;
    var anims:Array<AnimLoader>;
    var flipX:Bool;
	var flipY:Bool;
}

class Plant extends FlxSprite{

    public var jsonSystem:PlantJson;
    public var isAsleep:Bool = false;
	public var curPlant:String = 'peashooter';
    public var isShooting:Bool = false;
    public var animOffsets:Map<String, Array<Dynamic>>;

    public function new(x:Float, y:Float, ?plantName:String = "peashooter", ?asleep:Bool = false){
        super(x,y);
        curPlant = plantName;
        animOffsets = new Map<String, Array<Dynamic>>();
        isAsleep = asleep;
        var tex:FlxAtlasFrames;
        switch(curPlant)
        {
            case "peashooterA":
				// peashooter real
				tex = Paths.getSparrowAtlas('plants/peashooter');
				frames = tex;
				animation.addByPrefix('idle', 'peashooter idle',12,true);
                animation.addByPrefix('shoot', 'peashooter shoot',12,false);

                playAnim("idle");

            default:
                jsonSystem = Json.parse(Assets.getText(Paths.json(curPlant, 'data/plants/$curPlant')));

                tex = Paths.getSparrowAtlas('data/$curPlant/${jsonSystem.textureName}');
                frames = tex;

                for (anim in jsonSystem.anims){
					if (anim.fps < 1)
						anim.fps = 12;
					
					if (anim.looped != true && anim.looped != false)
						anim.looped = false;

					animation.addByPrefix(anim.prefix, anim.postfix, anim.fps, anim.looped);
					addOffset(anim.prefix, anim.x, anim.y);
				}

                flipX = jsonSystem.flipX;
				flipY = jsonSystem.flipY;
                
        }
        exist();
    }

    public function addOffset(name:String, x:Float = 0, y:Float = 0)
        {
            animOffsets[name] = [x, y];
        }

    public function exist(){
        if (!isShooting && animation.curAnim.finished){
            playAnim("idle");
        }

        if (isShooting){
            switch(curPlant)
            {
                case "peashooter":
                    if (animation.curAnim.name == 'idle' || animation.curAnim.name == 'shoot'  && animation.curAnim.finished){
                        playAnim("shoot");
                    }
            }
        }
    }

    override function update(elapsed:Float){
        if (animation.curAnim.finished)
            exist();

        super.update(elapsed);
    }

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		animation.play(AnimName, Force, Reversed, Frame); //so i dont specify EACH F###ING TIME
        var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName))
		{
			offset.set(daOffset[0], daOffset[1]);
		}
    }
}

