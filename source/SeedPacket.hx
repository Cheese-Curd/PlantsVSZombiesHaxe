package;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.group.FlxGroup;
import flixel.text.FlxText;

var priceTxt:FlxText;

class SeedPacket extends FlxSprite{

    public function new(x:Float, y:Float, character:String, priceValue:Int, ?notRecommended:Bool = false, ?isSpecial:Bool = false){
        super(x,y);
        this.loadGraphic("assets/images/ui/seedPackets/" + character + ".png");
        if (notRecommended)
            this.color = FlxColor.BLACK;
        priceTxt = new FlxText(x, y - 40, 100, '$priceValue'); // Adjust width as needed
        //HOW DO I ADD THE TEXT
    }


}