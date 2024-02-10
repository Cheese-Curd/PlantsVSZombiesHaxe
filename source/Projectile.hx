package;

import flixel.FlxSprite;

class Projectile extends FlxSprite{
    public function new(x:Float, y:Float, type:String = "pea"){
        super(x,y);
        var projectileSprite = new FlxSprite(x,y).loadGraphic('assets/images/projectiles/$type.png');
    }

    override function update(elapsed:Float){
        this.velocity.x = 100;

        //if (this.overlaps) leaving this for the zombies
        super.update(elapsed);
    }

}