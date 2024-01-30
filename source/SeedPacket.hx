package;

import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.text.FlxText;


var seedPacketSprite:FlxSprite;
var whatPlant:FlxSprite;
var price:Int;
var priceTxt:FlxText;

class SeedPacket extends FlxSprite{
    public function new(x:Float, y:Float, character:String, ?notRecommended:Bool = false, ?isSpecial:Bool = false){
        super(x,y);
        
        seedPacketSprite = new FlxSprite(0,0);
        seedPacketSprite.loadGraphic("assets/images/ui/seedpacketNormal.png");
        whatPlant = new FlxSprite(seedPacketSprite.x,seedPacketSprite.y);
        whatPlant.loadGraphic("assets/images/ui/seedPackets/" + character + ".png");
        trace("assets/images/ui/seedPackets/" + character + ".png");
        //whatPlant = new Plant(seedPacketSprite.x,seedPacketSprite.y,character,false,true);
        //whatPlant.setFrames(16);

    }


}