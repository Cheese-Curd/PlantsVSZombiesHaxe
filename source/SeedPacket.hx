package;

import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;


var seedPacketSprite:FlxSprite;
var whatPlant:Plant;
var seedPacketGroup:FlxTypedGroup<FlxSprite>;

class SeedPacket extends FlxSprite{
    public function new(character:String, ?notRecommended:Bool = false, ?isSpecial:Bool = false){
        super();
        seedPacketGroup = new FlxTypedGroup<FlxSprite>();
        
        seedPacketSprite = new FlxSprite(0,0).loadGraphic("assets/images/ui/seedpacketNormal.png");
        whatPlant = new Plant(seedPacketSprite.x,seedPacketSprite.y,character,false,true);
        //whatPlant.setFrames(16);
        seedPacketGroup.add(seedPacketSprite);
        seedPacketGroup.add(whatPlant);

        //add(seedPacketGroup);

    }


}