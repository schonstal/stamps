package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;

class Background extends FlxSpriteGroup {
  var background:FlxSprite;

  public function new():Void {
    super();

    background = new FlxSprite();
    background.loadGraphic("assets/images/backgrounds/red.png");
    add(background);
  }

  public override function update(elapsed:Float):Void {
    super.update(elapsed);
  }
}
