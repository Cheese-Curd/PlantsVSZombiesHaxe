package util;

import flixel.FlxSprite;

class PvzAnim extends FlxSpriteGroup
{
    var limbArray:Array<FlxSprite> = [];
    var limbNameArray:Array<FlxSprite> = [];

    var tex:FlxAtlasFrames;

    public function new(path:String,limbs:Array<String>){
        tex = Paths.getSparrowAtlas(path);
        frames = tex;
        for (limbName in limbs)
            createLimb(limbName)

    }
    public function createLimb(name:String,animName:String)
    {
        var limb:FlxSprite = new FlxSprite(0,0)
        animation.addByPrefix(anim.prefix, anim.postfix, 12, true);



    }

    

}