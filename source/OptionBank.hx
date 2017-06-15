package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.graphics.frames.FlxBitmapFont;
import flixel.text.FlxBitmapText;
import flixel.math.FlxPoint;

import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class OptionBank extends FlxGroup {
  public function new():Void {
    super();
  }

  public function show():Void {
    for (member in members) {
      cast(member, OptionGroup).appear();
    }
  }

  public function hide():Void {
    for (member in members) {
      cast(member, OptionGroup).disappear();
    }
  }
}
