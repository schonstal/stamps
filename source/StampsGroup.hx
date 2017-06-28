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
  var lastStamp:String;

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
      "car",
      "cheese",
      "cloud",
      "cloudLarge",
      "pup",
      "house",
      "basketball",
      "DunkColor",
      "BarkleyColor",
      "ClydeColor",
      "DennisColor",
      "MJcolor",
      "ScottieColor",
      "Shaq",
      "broken"
    ];

    clickCallback = onClick;
    loadThumbnails();
  }

  function onClick(path:String):Void {
    Reg.continuous = false;
    Reg.stamp.loadGraphic('assets/images/stamps/$path.png');
    Reg.stampSound = FlxG.sound.play('assets/sounds/stamps/$path.ogg', 1, false, null, false);
  }
}
