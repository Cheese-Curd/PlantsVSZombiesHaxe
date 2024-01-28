package;

import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;


var seedPacketSprite:FlxSprite;
var whatPlant:FlxSprite;

class SeedPacket extends FlxSprite{
    public function new(character:String, ?notRecommended:Bool = false, ?isSpecial:Bool = false){
        super();
        
        seedPacketSprite = new FlxSprite(0,0).loadGraphic("assets/images/ui/seedpacketNormal.png");
        whatPlant = new FlxSprite(seedPacketSprite.x,seedPacketSprite.y).loadGraphic("assets/images/ui/seedPackets/" + character + ".png");
        trace("assets/images/ui/seedPackets/" + character + ".png");
        //whatPlant = new Plant(seedPacketSprite.x,seedPacketSprite.y,character,false,true);
        //whatPlant.setFrames(16);

    }


}