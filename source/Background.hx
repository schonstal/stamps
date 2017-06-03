package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;

class Background extends FlxSpriteGroup {
  var background:FlxSprite;
  var backgrounds:Array<FlxSprite> = new Array<FlxSprite>();
  var activeIndex:Int = 0;

  public function new():Void {
    super();

    var backgroundPaths:Array<String> = PathHelper.imagesForPath(~/images\/backgrounds/i);

    for (path in backgroundPaths) {
      background = new FlxSprite();
      background.loadGraphic(path);
      backgrounds.push(background);
      background.visible = false;
      add(background);
    }

    backgrounds[0].visible = true;
  }

  public override function update(elapsed:Float):Void {
    super.update(elapsed);

    if (FlxG.keys.justPressed.LEFT) {
      activeIndex--;
      if (activeIndex < 0) activeIndex = backgrounds.length - 1;
    } else if (FlxG.keys.justPressed.RIGHT) {
      activeIndex++;
      if (activeIndex > backgrounds.length - 1) activeIndex = 0;
    }

    for (bg in backgrounds) {
      bg.visible = false;
    }

    backgrounds[activeIndex].visible = true;
  }
}
