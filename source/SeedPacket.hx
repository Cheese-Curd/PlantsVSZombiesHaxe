package;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;

var priceTxt:FlxText;
var spritePacket:FlxSprite;

class SeedPacket extends FlxSpriteGroup{

    public function new(x:Float, y:Float, character:String, priceValue:Int, ?notRecommended:Bool = false, ?isSpecial:Bool = false){
        super(x,y);
        spritePacket = new FlxSprite(x,y);
        spritePacket.loadGraphic("assets/images/ui/seedPackets/" + character + ".png");
        add(spritePacket);
        if (notRecommended)
            spritePacket.color = FlxColor.BLACK;
        priceTxt = new FlxText(x, y - 40, 100, '$priceValue');
        priceTxt.font = 'assets/fonts/vcr.ttf';
        add(priceTxt);
    }


}