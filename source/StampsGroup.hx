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

class StampsGroup extends OptionGroup {
  public function new():Void {
    super();

    prefix = "stamps";
    thumbnailPaths = [
      "bee",
      "cat",
      "catJump",
      "duck",
      "flower",
      "tree",
      "DunkColor",
      "BarkleyColor",
      "ClydeColor",
      "DennisColor",
      "MJColor",
      "ScottieColor",
      "Shaq",
      "broken"
    ];

    clickCallback = onClick;
    loadThumbnails();
  }

  function onClick(path:String):Void {
    Reg.continuous = false;
    Reg.stamp.loadGraphic(path);
  }
}
