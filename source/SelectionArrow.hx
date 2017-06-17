package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.graphics.frames.FlxBitmapFont;
import flixel.text.FlxBitmapText;
import flixel.math.FlxPoint;
import flixel.FlxObject;

class SelectionArrow extends FlxSprite {
  public var clickCallback:Void->Void;

  public function new(X:Float, Y:Float):Void {
    super(X, Y);

    loadGraphic("assets/images/ui/navArrows.png", true, 64, 64);
    animation.add("wiggle", [0, 1, 2], 8, true);
    animation.play("wiggle");
    setFacingFlip(FlxObject.LEFT, true, false);
  }

  public override function update(elapsed:Float):Void {
    super.update(elapsed);

    if (!visible) { return; }

    if (FlxG.mouse.x > x && FlxG.mouse.x < x + width &&
        FlxG.mouse.y > y && FlxG.mouse.y < y + height) {
      color = 0xffcccccc; //2d92bc;
      if (FlxG.mouse.justPressed && clickCallback != null && visible) {
        clickCallback();
      }
    } else {
      color = 0xffffffff;
    }
  }
}
