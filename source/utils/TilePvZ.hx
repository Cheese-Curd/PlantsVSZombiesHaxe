package utils;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;

typedef TileTypes = {
    var Plantable:Bool;
    var SpecialScript:Bool; //not implemented since hscript is not added
}

class TilePvZ extends FlxSpriteGroup
{

    public function new(x:Float = 0,y:Float = 0,row:Int = 1, col:Int = 1/*, type*/)
    {
        super(x,y);

        for (int in col){
            for (r in row){
                var tile = new FlxSprite(0 + (r * 10),0 + (c * 10));
                tile.makeGraphic(80,80,FlxColor.WHITE);
                this.add(tile);
            }
        }
    }

    function addrows(rows:Int,cols:Int){

        for (i in col){
            for (j in row){
                var tile = new FlxSprite(0 + (j * 10),0 + (i * 10));
                tile.makeGraphic(80,80,FlxColor.WHITE);
                this.add(tile);
            }
        }

    }

}