package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;

class Background extends FlxSpriteGroup {
  var background:FlxSprite;

  public function new():Void {
    super();

    var backgroundPaths:Array<String> = PathHelper.imagesForPath(~/images\/backgrounds/i);

    for (path in backgroundPaths) {
      background = new FlxSprite();
      background.loadGraphic(path);
      add(background);
    }
  }

  public override function update(elapsed:Float):Void {
    super.update(elapsed);
  }
}
