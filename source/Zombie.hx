package;

import flixel.FlxSprite;
import haxe.Json;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import openfl.Assets;

typedef ZAnimLoader =
{
	var prefix:String;
	var postfix:String;
	var x:Float;
	var y:Float;
	var fps:Int;
	var looped:Bool;
}

typedef ZombieJson= 
{
    var textureName:String;
    var health:Float;
    var speed:Float;
    var anims:Array<ZAnimLoader>;
    var flipX:Bool;
	var flipY:Bool;
}

class Zombie extends FlxSprite{

    public var jsonSystem:ZombieJson;
	public var curZombie:String = 'basic';
    public var isWalking:Bool = false;
    public var animOffsets:Map<String, Array<Dynamic>>;

    public function new(x:Float, y:Float, ?zombieName:String = "basic", ?shouldWalk:Bool = false){
        super(x,y);
        curZombie = zombieName;
        animOffsets = new Map<String, Array<Dynamic>>();
        isWalking = shouldWalk;
        var tex:FlxAtlasFrames;
        switch(curZombie)
        {
            default:
                jsonSystem = Json.parse(Assets.getText(Paths.json(curZombie, 'data/zombies/$curZombie')));

                tex = Paths.getSparrowAtlas('zombies/$curZombie/${jsonSystem.textureName}');
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
                
                if (!isWalking)
                    playAnim("idle");
                else
                    playAnim("walk");
        }
    }

    override function update(elapsed:Float){
        if (animation.curAnim.finished)
            exist();

        super.update(elapsed);
    }

    public function exist(){

        if (isWalking){
            this.velocity.x = jsonSystem.speed - (jsonSystem.speed * 2); // makes the value negative so it goes left
            playAnim("walk");
        }

        if (animation.curAnim.finished && animation.curAnim.name == "idle" && !isWalking)
            playAnim("idle");

    }
    public function addOffset(name:String, x:Float = 0, y:Float = 0)
        {
            animOffsets[name] = [x, y];
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

