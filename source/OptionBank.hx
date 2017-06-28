package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.graphics.frames.FlxBitmapFont;
import flixel.text.FlxBitmapText;
import flixel.math.FlxPoint;
import flixel.FlxObject;

import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class OptionBank extends FlxGroup {
  var leftArrow:FlxSprite;
  var rightArrow:FlxSprite;

  public function new():Void {
    super();

    leftArrow = new SelectionArrow(0, FlxG.height - 64);
    leftArrow.facing = FlxObject.LEFT;
    add(leftArrow);

    rightArrow = new SelectionArrow(FlxG.camera.width - 64, FlxG.height - 64);
    add(rightArrow);
  }

  public function show():Void {
    for (member in members) {
      if (member != leftArrow && member != rightArrow) {
        cast(member, OptionGroup).appear();
      }
    }
  }

  public function hide():Void {
    for (member in members) {
      if (member != leftArrow && member != rightArrow) {
        cast(member, OptionGroup).disappear();
      }
    }
  }
}
