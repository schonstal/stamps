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

class OptionGroup extends FlxSpriteGroup {
  static inline var GROUP_SIZE:Int = 6;

  public var clickCallback:String->Void;

  var groupIndex:Int = 0;
  var numGroups:Int = 0;
  var leftArrow:SelectionArrow;
  var rightArrow:SelectionArrow;

  var thumbnails:FlxSpriteGroup;

  var prefix:String = "";
  var thumbnailPaths:Array<String> = new Array<String>();

  public function new():Void {
    super(0, FlxG.height - 68);

    thumbnails = new FlxSpriteGroup();
    add(thumbnails);

    leftArrow = new SelectionArrow(0, 8);
    leftArrow.facing = FlxObject.LEFT;
    leftArrow.visible = false;
    leftArrow.clickCallback = function():Void {
      if (groupIndex > 0) {
        groupIndex--;
        hide();
        show(FlxObject.LEFT);
      }
    };
    add(leftArrow);

    rightArrow = new SelectionArrow(576, 8);
    rightArrow.visible = false;
    rightArrow.clickCallback = function():Void {
      if (groupIndex < numGroups) {
        groupIndex++;
        hide();
        show(FlxObject.RIGHT);
      }
    };
    add(rightArrow);
  }

  function loadThumbnails():Void {
    var i = 0;
    numGroups = Std.int((thumbnailPaths.length - 1) / GROUP_SIZE);

    for (thumbnailPath in thumbnailPaths) {
      var thumbnail = new ThumbnailFrame('assets/images/$prefix/thumbs/$thumbnailPath.png');
      thumbnail.x = 68 + ((i%GROUP_SIZE) * (thumbnail.width + 25));
      thumbnail.clickCallback = function():Void {
        clickCallback(thumbnailPath);
      }

      thumbnails.add(thumbnail);

      i++;
    }
  }

  public function show(direction:Int = 0):Void {
    rightArrow.visible = (groupIndex < numGroups);
    leftArrow.visible = (groupIndex > 0);

    var start:Int = GROUP_SIZE * groupIndex;
    var end:Int = start + GROUP_SIZE;

    for (i in start...end) {
      if (thumbnails.members[i] != null) {
        var increment:Float = 0;
        if (direction == FlxObject.RIGHT) {
          increment = (i % GROUP_SIZE) * 0.025;
        } else if (direction == FlxObject.LEFT) {
          increment = (GROUP_SIZE - (i % GROUP_SIZE)) * 0.025;
        }

        cast(thumbnails.members[i], ThumbnailFrame).appear(increment);
      }
    }
  }

  public function hide():Void {
    for (thumb in thumbnails.members) {
      cast(thumb, ThumbnailFrame).disappear();
    }

    leftArrow.visible = false;
    rightArrow.visible = false;
  }

  function showArrows():Void {
    leftArrow.visible = (groupIndex > 0);
    rightArrow.visible = (groupIndex < numGroups);
  }
}
