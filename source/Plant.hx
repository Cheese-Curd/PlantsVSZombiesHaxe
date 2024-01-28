package;

import flixel.FlxSprite;
import haxe.Json;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;

typedef AnimLoader =
{
	var prefix:String;
	var postfix:String;
	var x:Float;
	var y:Float;
	var fps:Int;
	var looped:Bool;
	var indices:Array<Int>;
}

typedef PlantJson= 
{
    var textureName:String;
    var health:Float;
    var isSpecial:Bool;
    var anims:Array<AnimLoader>;
}

class Plant extends FlxSprite{

    public var jsonSystem:PlantJson;
    public var isAsleep:Bool = false;
	public var curPlant:String = 'peashooter';
    public var isShooting:Bool = false;
    public var isStatic:Bool = false;

    public function new(x:Float, y:Float, ?plantName:String = "peashooter", ?asleep:Bool = false, ?staticAnim:Bool = false){
        super(x,y);
        curPlant = plantName;
        isAsleep = asleep;
        isStatic = staticAnim;
        var tex:FlxAtlasFrames;
        switch(curPlant)
        {
            case "peashooter":
				// peashooter real
				tex = Paths.getSparrowAtlas('plants/peashooter');
				frames = tex;
				addAnim('idle', 'peashooter idle');
                addAnim('shoot', 'peashooter shoot');

                if (!isStatic)
                    playAnim("idle");

            default:
               // default real
                tex = Paths.getSparrowAtlas('plants/peashooter');
                frames = tex;
                addAnim('idle', 'peashooter idle');
                addAnim('shoot', 'peashooter shoot');
                
                if (!isStatic)
                    playAnim("idle");
        }
        exist();
    }

    public function exist(){
        if (!isShooting && animation.curAnim.finished && !isStatic){
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

	function addAnim(name:String, prefix:String)
        {
            animation.addByPrefix(name, prefix, 24, false);
        }

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		animation.play(AnimName, Force, Reversed, Frame); //so i dont specify EACH F###ING TIME
    }
}

