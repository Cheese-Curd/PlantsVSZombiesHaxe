package;

import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.text.FlxText;

var price:Int;
var priceTxt:FlxText;

class SeedPacket extends FlxSprite{
    public function new(x:Float, y:Float, character:String, priceValue:Int, ?notRecommended:Bool = false, ?isSpecial:Bool = false){
        super(x,y);
        this.loadGraphic("assets/images/ui/seedPackets/" + character + ".png");
        priceTxt = new FlxText(x, y - 40, 100, '$priceValue'); // Adjust width as needed
    }


}