package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.graphics.frames.FlxBitmapFont;
import flixel.text.FlxBitmapText;
import flixel.math.FlxPoint;
import flixel.FlxObject;

import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class BrushGroup extends OptionGroup {
  public function new():Void {
    super();

    prefix = "palette";
    thumbnailPaths = [
      "red",
      "blue",
      "green",
      "yellow",
      "lavendar",
      "pink",
      "black",
      "white",
      "darkBlue",
      "darkBrown",
      "tan",
      "peach"
    ];

    clickCallback = onClick;
    loadThumbnails();
  }

  function onClick(path:String):Void {
    Reg.continuous = true;
    Reg.stamp.loadGraphic(path);
  }
}
